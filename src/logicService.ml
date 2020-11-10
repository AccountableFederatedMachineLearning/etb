open Default

module Log = struct
  let trace x = Js.Console.log("[trace] " ^ (Js.String.make x))
  let info x = Js.Console.info("[info] " ^ (Js.String.make x))
end

(** State of the logic service *)
type t = {
  db : Default.db;
  mutable id : Id.t;
  mutable contract : Fabric.contract option;
  mutable log_queue : string list
}


module Encoding : sig

  type color =
    | Yellow
    | Green

  (* TODO: encapsulation *)
  type literal = Default.literal
  type clause = Default.clause

  val color : literal -> color
  val principal : literal -> Id.t

  val mk_literal : Default.literal -> color -> Id.t -> literal
  val mk_clause : Default.clause -> Id.t -> clause

  val plain_literal : literal -> Default.literal
  val to_string : literal -> string

end = struct

  type color =
    | Yellow
    | Green

  type literal = Default.literal
  type clause = Default.clause

  let color_term c = 
    let yellow = mk_const (StringSymbol.make "yellow") in
    let green = mk_const (StringSymbol.make "green") in
    match c with 
    | Yellow -> yellow 
    | Green -> green

  let principal_term id = 
    mk_const (StringSymbol.make (Id.to_string id))

  let color_from_term c = 
    if eq_term c (color_term Yellow) then Yellow
    else if eq_term c (color_term Green) then Green
    else failwith "term must be yellow or green"

  let principal_from_term c = 
    match c with
    | Var _ -> failwith "color is variable"
    | Const p -> 
      let s = StringSymbol.to_string p in
      Id.from_string_exn s

  let is_color_term c =
    ignore (color_from_term c); (* fails if c is not color *)
    true

  let color literal =
    match open_literal literal with
    | (_, []) -> failwith "literal has no color"
    | (_, (a :: _)) -> color_from_term a

  let principal literal =
    match open_literal literal with
    | (_, []) -> failwith "literal has no color"
    | (_, [_]) -> failwith "literal has no princial"
    | (_, (_ :: p :: _)) -> principal_from_term p

  let mk_open_literal s color_tm principal_tm args =
    mk_literal s (color_tm :: principal_tm :: args)

  let mk_literal fact color id =
    let (s, args) = open_literal fact in
    mk_open_literal s (color_term color) (principal_term id) args

  let mk_clause clause id =
    let ((s, args), body) = Default.open_clause clause in
    let yellow_head = mk_open_literal s (color_term Yellow) (principal_term id) args in
    let any_args = List.mapi (fun i (s, args) -> 
        mk_open_literal s (mk_var (-i-1)) (principal_term id) args) body in
    Default.mk_clause yellow_head any_args

  let plain_literal literal =
    match open_literal literal with
    | (_, []) 
    | (_, [_]) -> failwith "plain_literal may only be applied to encoded literals"
    | (s, c :: _ :: args) ->
      assert (is_color_term c);
      Default.mk_literal s args

  (* Maybe move out *)
  let to_string literal =
    let color = match color literal with 
      | Yellow -> "yellow"
      | Green -> "green" in
    let principal = match Id.Name.get (principal literal).subject "CN" with
      | None -> "<unknown>"
      | Some n -> n in
    let claim = Syntax.string_of_literal (plain_literal literal) in
    principal ^ " says " ^ claim ^ " [" ^ color ^ "]"

end 

let all_facts t =
  db_fold (fun facts clause ->
      if is_fact clause then clause :: facts else facts) [] t.db

(* Log all queued messages to the chain (in unspecified order) *)
let flush_queue t =
  match t.contract with
  | None -> Js.Promise.resolve ()
  | Some contract ->
    let messages = t.log_queue in
    t.log_queue <- [];
    let log m = 
      Log.trace("logging " ^ m); 
      Fabric.log contract m in      
    Js.Promise.all (messages |> List.map log |> Array.of_list)
    |> Js.Promise.then_ (fun _ -> Js.Promise.resolve ())

(* TODO: need to check that it's ground *)
let add_fact t fact =  
  let yellow_fact = Encoding.mk_literal fact Yellow t.id in
  Default.db_add_fact t.db yellow_fact;
  flush_queue t

let add_clause t clause =
  let encoded_clause = Encoding.mk_clause clause t.id in
  Log.trace(Syntax.string_of_clause encoded_clause);
  db_add t.db encoded_clause

let create prg id = 
  let t = {
    db = Default.db_create ();
    id = id;
    contract = None;
    log_queue = []
  } in

  let fact_handler (fact : literal) : unit =
    Log.trace("adding fact '" ^ (Encoding.to_string fact) ^ "' to db");
    if (Encoding.color fact = Yellow) then (
      let plain_fact = Encoding.plain_literal fact in
      let plain_fact_string = Syntax.string_of_literal plain_fact in
      Log.trace("queueing " ^ plain_fact_string);
      t.log_queue <- plain_fact_string :: t.log_queue
    ) in

  db_subscribe_all_facts t.db fact_handler;

  List.iter (add_clause t) prg;
  t

let register_service t symbol handler =
  Default.db_subscribe_goal t.db (fun goal ->
      let (f, _) = open_literal goal in
      if f = symbol then handler goal else ())

module ClaimEvent = struct

  type t = {
    subjectID : string;
    issuerID : string;
    claim : string
  }

  let parse_exn (s : string) =
    match Js.Json.decodeObject (Js.Json.parseExn s) with
    | Some o -> 
      let get_string key = 
        match Js_dict.get o key with
        | Some v -> 
          begin 
            match Js.Json.decodeString v with
            | Some s -> s
            |None -> failwith "Not a string value"
          end
        | None -> failwith ("Key " ^ key ^ " required") in
      { subjectID = get_string "subjectID";
        issuerID = get_string "issuerID";
        claim = get_string "claim"
      }
    | None -> failwith ("JSON object expected" ^ s)
end

let connect_to_contract t contract = 
  Log.info("Connecting to contract");
  t.contract <- Some contract;

  let listener (payload: string): unit Js.Promise.t =
    Log.trace("receiving event '" ^ payload ^ "'");
    (try
       let open ClaimEvent in
       let claim_event = ClaimEvent.parse_exn payload in
       let id = Id.of_DNs_exn (claim_event.subjectID) (claim_event.issuerID) in
       let plain_literal = Syntax.parse_literal_exn claim_event.claim in
       let encoded_literal = Encoding.mk_literal plain_literal Green id in
       db_add_fact t.db encoded_literal
     with _ ->
       Log.trace("Error when adding '" ^ payload ^ "'")
    );
    flush_queue t in

  Fabric.add_contract_listener contract listener 
  |> Js.Promise.then_ (fun () -> 
      flush_queue t
    )
