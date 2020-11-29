open Default
open Promise

(** State of the logic service *)
type t = { 
  db : Cyberlogic.db;
  id : Id.t;
  mutable contract : Fabric.contract option;
  mutable pending : (unit -> unit Js.Promise.t) list;
}

let run_later t (action : unit -> unit Js.Promise.t) =
  t.pending <- action :: t.pending

(* Execute all pending actions (in unspecified order) *)
let flush_pending t : unit Js.Promise.t =
  let pending = t.pending in
  t.pending <- [];
  let promises = List.map (fun action -> action ()) pending in
  Js.Promise.all (Array.of_list promises) >>= fun _ ->
  pure ()

(* Fact handler to queue yellow facts *)
let log_yellow_facts t : Cyberlogic.fact_handler =
  fun (fact : Cyberlogic.Literal.t) ->
  Logger.fdebug "adding fact '%s' to db" (Syntax.Cyberlogic.short_literal fact);
  match Cyberlogic.Literal.color fact with
  | Yellow ->
    Logger.debug("queueing log(" ^ Syntax.Cyberlogic.short_literal fact ^ ")");
    let rec log_action () = 
      match t.contract with
      | Some contract ->
        Fabric.add_claim contract Cyberlogic.Literal.((to_json fact).literal) 
      | None -> 
        (* If no contract is installed, log the action again for later execution *)
        run_later t log_action;
        pure () in
    run_later t log_action
  | _ -> ()

let json_handler t : Cyberlogic.goal_handler =
  let no_quotes_exn s = 
    if String.length s >= 2 && 
       String.get s 0 = '\'' && 
       String.get s (String.length s - 1) = '\''
    then String.sub s 1 (String.length s - 2) 
    else s in
  let json_of_const_exn c = match c with
    | Const s -> Js.Json.parseExn (no_quotes_exn (StringSymbol.to_string s))
    | _ -> failwith "no const" in
  let array_of_const_exn c = 
    Belt.Option.getExn (Js.Json.decodeArray (json_of_const_exn c)) in
  let object_of_const_exn c = 
    Belt.Option.getExn (Js.Json.decodeObject (json_of_const_exn c)) in
  fun (goal : Cyberlogic.Literal.t) ->
    let h, a = Default.open_literal (Cyberlogic.Literal.plain_literal goal) in
    Logger.debug("goal '" ^ (Syntax.Cyberlogic.short_literal goal) ^ "'");
    begin
      match Default.StringSymbol.to_string h, a with
      | "length", [(Const _) as array_const; _] -> 
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
      | "get", [(Const _) as obj_const; (Const field_sym) as field_const; _] -> 
        begin
          try
            let obj = object_of_const_exn obj_const in
            let field = no_quotes_exn (Default.StringSymbol.to_string field_sym) in
            let value_const = Js_dict.get obj field 
                              |> Belt.Option.getExn 
                              |> Js.Json.stringify
                              |> Default.StringSymbol.make
                              |> Default.mk_const in
            Js.log(value_const);
            let x = Cyberlogic.Literal.make h Cyberlogic.Yellow t.id 
                [obj_const; field_const; value_const] in
            Cyberlogic.db_add_fact t.db x
          with
            _ -> ()
          (* if anything fails, add nothing *)
        end
      | _ -> ()
    end 

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

let claim_event_listener t (payload: string): unit Js.Promise.t =
  Logger.debug("receiving event '" ^ payload ^ "'");
  begin
    try
      let open ClaimEvent in
      let claim_event = ClaimEvent.parse_exn payload in
      let id = Id.of_DNs_exn ~subjectDN:(claim_event.subjectID) 
          ~issuerDN:(claim_event.issuerID) in
      let plain_literal = Syntax.Datalog.parse_literal_exn claim_event.claim in
      let (s, args) = Default.open_literal plain_literal in
      let green_literal = Cyberlogic.Literal.make s Green id args in
      Cyberlogic.db_add_fact t.db green_literal
    with _ ->
      Logger.debug("Error when adding '" ^ payload ^ "'")
  end;
  flush_pending t

let create id clauses = 
  let t = { 
    db = Cyberlogic.db_create ();
    id = id;
    contract = None;
    pending = []
  } in
  Cyberlogic.db_subscribe_all_facts t.db (log_yellow_facts t);
  Cyberlogic.db_subscribe_goal t.db (json_handler t);
  clauses |> List.iter (fun clause ->
      Logger.debug (Syntax.Cyberlogic.short_clause clause);
      Cyberlogic.db_add t.db clause
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

(*
let register_service t symbol handler =
  Cyberlogic.db_subscribe_goal t.db (fun goal ->
      let (f, _) = open_literal goal in
      if f = symbol then handler goal else ())
*) 

let connect_to_contract t contract = 
  Logger.info "Connecting to contract";
  t.contract <- Some contract;
  Fabric.add_contract_listener contract (claim_event_listener t) >>= fun () ->
  flush_pending t

let add_fact_listener t (listener : Cyberlogic.Literal.t -> unit Js.Promise.t) = 
  Cyberlogic.db_subscribe_all_facts t.db 
    (fun fact -> run_later t (fun () -> listener fact))