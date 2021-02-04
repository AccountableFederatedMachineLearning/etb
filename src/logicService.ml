open Default
open Promise

external transaction_limit_per_second : int = 
  "transaction_limit_per_second" [@@bs.module("./config.js")]

(** State of the logic service *)
type t = { 
  db : Cyberlogic.db;
  id : Cyberlogic.Principal.t;  
  mutable contract : Fabric.contract option;
  mutable pending : (unit -> unit Js.Promise.t) list;
  mutable last_flushed: float;
}

let run_later t (action : unit -> unit Js.Promise.t) =
  t.pending <- action :: t.pending


(* Execute all pending actions (in unspecified order). *)
let rec flush_pending t : unit Js.Promise.t =
  let one_second = 1000.0 in
  if t.pending = [] then
    pure ()
  else if (Js.Date.now() -. t.last_flushed < one_second) then
    pure ()
  else
    let send, keep = 
      match Belt.List.splitAt t.pending transaction_limit_per_second with 
      | Some(h, t) -> h, t
      | None -> t.pending, [] in
    t.pending <- keep;
    t.last_flushed <- Js.Date.now();
    Logger.debug 
      (Printf.sprintf "Submitting %i transactions; keeping %i transactions in the queue." 
         (List.length send) (List.length keep));
    List.fold_left (fun c action -> c >>= fun _ -> action ()) (pure ()) send

(* With rate limiting, not all queued functions are flushed every time.
   To ensure that everything is flushed eventually, we just flush regularly. *)
let rec flush_every_2s t = 
  flush_pending t >>= fun _ -> 
  Promise.wait 2000 >>= fun _ -> 
  flush_every_2s t

(* Fact handler to queue yellow facts *)
let log_yellow_facts t : Cyberlogic.fact_handler =
  fun (fact : Cyberlogic.Literal.t) ->
  Logger.fdebug "adding fact '%s' to db" (Syntax.Cyberlogic.short_literal fact);
  (* TODO: only log own facts *)  
  if Cyberlogic.(Principal.equals (Literal.principal fact) t.id) then
    begin
      (* let clause, premises = Cyberlogic.db_premises t.db fact in
         Logger.debug 
         (Printf.sprintf
           "  - the fact was derived by clause '%s' with premises [%s]." 
           (Syntax.Cyberlogic.short_clause clause)
           (String.concat ", " (List.map Syntax.Cyberlogic.short_literal premises))); *)
      match Cyberlogic.Literal.color fact with
      | Yellow ->
        Logger.debug("queueing log(" ^ Syntax.Cyberlogic.short_literal fact ^ ")");
        let rec log_action () = 
          match t.contract with
          | Some contract ->
            let plain_literal = Cyberlogic.Literal.plain_literal fact in
            Default.pp_literal Format.str_formatter plain_literal;
            let literal_string = Format.flush_str_formatter () in
            Fabric.add_claim contract literal_string
          | None -> 
            (* If no contract is installed, log the action again for later execution *)
            run_later t log_action;
            pure () in
        run_later t log_action;
      | _ -> ()
    end

let json_handler t : Cyberlogic.goal_handler =
  let no_quotes_exn s = 
    if String.length s >= 2 && 
       String.get s 0 = '\'' && 
       String.get s (String.length s - 1) = '\''
    then String.sub s 1 (String.length s - 2) 
    else s in
  let quote s = "'" ^ s ^ "'" in
  let int_of_symbol_exn s = int_of_string (Default.StringSymbol.to_string s) in
  let json_of_const_exn c = match c with
    | Const s -> Js.Json.parseExn (no_quotes_exn (StringSymbol.to_string s))
    | _ -> failwith "no const" in
  let array_of_const_exn c = 
    Belt.Option.getExn (Js.Json.decodeArray (json_of_const_exn c)) in
  let object_of_const_exn c = 
    Belt.Option.getExn (Js.Json.decodeObject (json_of_const_exn c)) in
  let string_of_const_exn c = 
    Belt.Option.getExn (Js.Json.decodeString (json_of_const_exn c)) in
  fun (goal : Cyberlogic.Literal.t) ->
    let h, a = Default.open_literal (Cyberlogic.Literal.plain_literal goal) in
    Logger.debug("goal '" ^ (Syntax.Cyberlogic.short_literal goal) ^ "'");
    begin
      match Default.StringSymbol.to_string h, a with
      | "json_array_length", [(Const _) as array_const; _] -> 
        begin
          try
            let array = array_of_const_exn array_const in
            let length_const = Array.length array
                               |> string_of_int 
                               |> Default.StringSymbol.make
                               |> Default.mk_const in
            let x = Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
                [array_const; length_const] in
            Cyberlogic.db_add_fact t.db x
          with
            _ -> ()
          (* if anything fails, add nothing *)
        end
      | "json_array_get", [(Const _) as array_const; (Const index) as index_const; _] -> 
        begin
          try
            let array = array_of_const_exn array_const in
            let i = int_of_symbol_exn index in
            let value_const = Array.get array i
                              |> Js.Json.stringify
                              |> quote
                              |> Default.StringSymbol.make
                              |> Default.mk_const in
            let x = Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
                [array_const; index_const; value_const] in
            Cyberlogic.db_add_fact t.db x
          with
            _ -> ()
          (* if anything fails, add nothing *)
        end
      | "json_object_get", [(Const _) as obj_const; (Const field_sym) as field_const; _] -> 
        begin
          try
            let obj = object_of_const_exn obj_const in
            let field = no_quotes_exn (Default.StringSymbol.to_string field_sym) in
            let value_const = Js_dict.get obj field 
                              |> Belt.Option.getExn 
                              |> Js.Json.stringify
                              |> quote
                              |> Default.StringSymbol.make
                              |> Default.mk_const in
            let x = Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
                [obj_const; field_const; value_const] in
            Cyberlogic.db_add_fact t.db x
          with
            _ -> ()
          (* if anything fails, add nothing *)
        end
      | "json_string_get", [(Const _) as str_const; _] ->
        begin
          try        
            let str = string_of_const_exn str_const in
            Cyberlogic.db_add_fact t.db 
              (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
                 [str_const; Default.mk_const (StringSymbol.make (quote str))])
          with
            e -> Js.log(e)
        end
      | "int_of_string", [Const s as s_const; _] ->         
        Cyberlogic.db_add_fact t.db 
          (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
             [s_const; Default.mk_const (StringSymbol.make (no_quotes_exn (StringSymbol.to_string s)))])
      | _ -> ()
    end     

let int_handler t : Cyberlogic.goal_handler =
  let int_of_symbol s = int_of_string (Default.StringSymbol.to_string s) in
  let const_of_int i = Default.mk_const (Default.StringSymbol.make (string_of_int i)) in
  fun (goal : Cyberlogic.Literal.t) ->
    let h, a = Default.open_literal (Cyberlogic.Literal.plain_literal goal) in
    try
      match Default.StringSymbol.to_string h, a with
      | "le", [Const i; Const j] -> 
        if int_of_symbol i <= int_of_symbol j then
          Cyberlogic.db_add_fact t.db (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id a)
      | "lt", [Const i; Const j] -> 
        if int_of_symbol i < int_of_symbol j then
          Cyberlogic.db_add_fact t.db (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id a)
      | "gt", [Const i; Const j] -> 
        if int_of_symbol i > int_of_symbol j then
          Cyberlogic.db_add_fact t.db (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id a)
      | "ge", [Const i; Const j] -> 
        if int_of_symbol i >= int_of_symbol j then
          Cyberlogic.db_add_fact t.db (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id a)
      | "add", [Const i as i_const; Const j as j_const; _] ->         
        Cyberlogic.db_add_fact t.db 
          (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
             [i_const; j_const; const_of_int (int_of_symbol i + int_of_symbol j)])
      | "sub", [Const i as i_const; Const j as j_const; _] ->         
        Cyberlogic.db_add_fact t.db 
          (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
             [i_const; j_const; const_of_int (int_of_symbol i - int_of_symbol j)])
      | "mul", [Const i as i_const; Const j as j_const; _] ->         
        Cyberlogic.db_add_fact t.db 
          (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
             [i_const; j_const; const_of_int (int_of_symbol i * int_of_symbol j)])
      | _ -> ()
    with 
    (* if anything fails, do nothing *)
    | _ -> ()

let general_handler t : Cyberlogic.goal_handler =
  fun (goal : Cyberlogic.Literal.t) ->
  let h, a = Default.open_literal (Cyberlogic.Literal.plain_literal goal) in
  try
    match Default.StringSymbol.to_string h, a with
    | "eq", [Const i; Const j] -> 
      if Default.StringSymbol.equal i j then
        Cyberlogic.db_add_fact t.db (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id a)
    | "ne", [Const i; Const j] -> 
      if not (Default.StringSymbol.equal i j) then
        Cyberlogic.db_add_fact t.db (Cyberlogic.Literal.make h Cyberlogic.Yellow t.id a)
    | _ -> ()
  with 
  (* if anything fails, do nothing *)
  | _ -> ()


(** Payload of claim events *)
module ClaimEvent = struct

  type t = { 
    subjectID : string;
    issuerID : string;
    claim : string 
  }

  let parse_exn (s : string) =
    match Js.Json.decodeObject (Js.Json.parseExn s) with
    | None -> failwith ("ClaimEvent: JSON object expected" ^ s)
    | Some o ->
      let get_string key = 
        match Js_dict.get o key with
        | None -> failwith ("ClaimEvent: Key " ^ key ^ " required")
        | Some v ->
          match Js.Json.decodeString v with
          | None -> failwith "ClaimEvent: Not a string value"
          | Some s -> s in
      { subjectID = get_string "subjectID";
        issuerID = get_string "issuerID";
        claim = get_string "claim"
      }
end

let claim_event_listener t (payload: string) (transactionId: string)
  : unit Js.Promise.t =
  Logger.debug("receiving event: transaction " ^ 
               transactionId ^ ": '" ^ payload ^ "'");
  begin
    try
      let open ClaimEvent in
      let claim_event = ClaimEvent.parse_exn payload in
      let id = Id.of_DNs_exn ~subjectDN:(claim_event.subjectID) 
          ~issuerDN:(claim_event.issuerID) in
      let principal = Cyberlogic.Principal.Id id in
      let plain_literal = Syntax.Datalog.parse_literal_exn claim_event.claim in
      let (s, args) = Default.open_literal plain_literal in
      let green = Cyberlogic.Green(transactionId) in
      let green_literal = Cyberlogic.Literal.make s green principal args in
      Cyberlogic.db_add_fact t.db green_literal
    with _ ->
      Logger.debug("Error when adding '" ^ payload ^ "'")
  end;
  flush_pending t

let create id prg = 
  let t = { 
    db = Cyberlogic.db_create ();
    id = Cyberlogic.Principal.Id id;
    contract = None;
    pending = [];
    last_flushed = 0.0;
  } in
  Cyberlogic.db_subscribe_all_facts t.db (log_yellow_facts t);
  Cyberlogic.db_subscribe_goal t.db (json_handler t);
  Cyberlogic.db_subscribe_goal t.db (int_handler t);
  Cyberlogic.db_subscribe_goal t.db (general_handler t);
  prg.Cyberlogic.clauses |> List.iter (fun clause ->
      Logger.debug (Syntax.Cyberlogic.short_clause clause);
      Cyberlogic.db_add t.db clause
    );
  prg.Cyberlogic.goals |> List.iter (fun goal ->
      Logger.debug ("Adding goal : " ^ (Syntax.Cyberlogic.short_literal goal));
      Cyberlogic.db_goal t.db goal
    );
  t

(* TODO: need to check that it's ground *)
let add_fact t fact =  
  let (s, args) = open_literal fact in
  let yellow_literal = Cyberlogic.Literal.make s Yellow t.id args in
  let yellow_clause = Cyberlogic.Clause.make yellow_literal [] in
  (* TODO *)
  if not (Cyberlogic.db_mem t.db yellow_clause) then
    Cyberlogic.db_add_fact t.db yellow_literal;
  flush_pending t

let all_facts t =
  Cyberlogic.db_fold (fun facts clause ->
      if Cyberlogic.Clause.is_fact clause then clause :: facts else facts
    ) [] t.db

let goal t goal =
  let (s, args) = open_literal goal in
  let yellow_goal = Cyberlogic.Literal.make s Yellow t.id args in
  Cyberlogic.db_goal t.db yellow_goal;
  flush_pending t

let connect_to_contract t contract = 
  Logger.info "Connecting to contract";
  t.contract <- Some contract; 
  Fabric.add_contract_listener contract (claim_event_listener t) >>= fun () ->
  flush_every_2s t

let add_fact_listener t (listener : Cyberlogic.Literal.t -> unit) = 
  Cyberlogic.db_subscribe_all_facts t.db 
    (fun fact -> listener fact)