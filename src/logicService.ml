open Default

module Log = struct
  let trace x = Js.Console.log("[trace] " ^ (Js.String.make x))
  let info x = Js.Console.info("[info] " ^ (Js.String.make x))
end

(** State of the logic service *)
type t = { 
  db : Cyberlogic.db;
  mutable id : Id.t;
  mutable contract : Fabric.contract option;
  mutable log_queue : Default.literal list 
}

(* Log all queued messages to the chain (in unspecified order) *)
let flush_queue t : unit Js.Promise.t =
  match t.contract with
  | None -> Js.Promise.resolve ()
  | Some contract ->
    let messages = t.log_queue in
    t.log_queue <- [];
    let log literal = 
      let m = Syntax.Datalog.string_of_literal literal in
      Log.trace("logging " ^ m); 
      Fabric.log contract m in      
    Js.Promise.all (messages |> List.map log |> Array.of_list)
    |> Js.Promise.then_ (fun _ -> Js.Promise.resolve ())

(* Fact handler to queue all quellow facts *)
let queue_yellow_facthandler t : Cyberlogic.fact_handler =
  fun (fact : Cyberlogic.literal) ->
  Log.trace("adding fact '" ^ (Syntax.Cyberlogic.short_literal fact) ^ "' to db");
  if (Cyberlogic.color fact = Yellow) then 
    begin
      Log.trace("queueing " ^ Syntax.Cyberlogic.short_literal fact);
      t.log_queue <- Cyberlogic.plain_literal fact :: t.log_queue
    end

(* Fact handler to queue all quellow facts *)
let goalhandler t : Cyberlogic.goal_handler =
  fun (goal : Cyberlogic.literal) ->
  Log.trace("goal '" ^ (Syntax.Cyberlogic.short_literal goal) ^ "'")

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
            | None -> failwith "Not a string value"
          end
        | None -> failwith ("Key " ^ key ^ " required") in
      { subjectID = get_string "subjectID";
        issuerID = get_string "issuerID";
        claim = get_string "claim"
      }
    | None -> failwith ("JSON object expected" ^ s)
end

let claim_event_listener t (payload: string): unit Js.Promise.t =
  Log.trace("receiving event '" ^ payload ^ "'");
  (try
     let open ClaimEvent in
     let claim_event = ClaimEvent.parse_exn payload in
     let id = Id.of_DNs_exn (claim_event.subjectID) (claim_event.issuerID) in
     let plain_literal = Syntax.Datalog.parse_literal_exn claim_event.claim in
     let (s, args) = Default.open_literal plain_literal in
     let encoded_literal = Cyberlogic.mk_literal s Green id args in
     Cyberlogic.db_add_fact t.db encoded_literal
   with _ ->
     Log.trace("Error when adding '" ^ payload ^ "'")
  );
  flush_queue t

let create id clauses = 
  let t = { 
    db = Cyberlogic.db_create ();
    id = id;
    contract = None;
    log_queue = []
  } in
  Cyberlogic.db_subscribe_all_facts t.db (queue_yellow_facthandler t);
  Cyberlogic.db_subscribe_goal t.db (goalhandler t);
  clauses |> List.iter (fun clause ->
      Log.trace (Syntax.Cyberlogic.short_clause clause);
      Cyberlogic.db_add t.db clause);
  t

(* TODO: need to check that it's ground *)
let add_fact t fact =  
  let (s, args) = open_literal fact in
  let yellow_fact = Cyberlogic.mk_literal s Yellow t.id args in
  Cyberlogic.db_add_fact t.db yellow_fact;
  flush_queue t

let all_facts t =
  Cyberlogic.db_fold (fun facts clause ->
      if Cyberlogic.is_fact clause then clause :: facts else facts) [] t.db

let goal t goal =
  let (s, args) = open_literal goal in
  let yellow_goal = Cyberlogic.mk_literal s Yellow t.id args in
  Cyberlogic.db_goal t.db yellow_goal;
  flush_queue t

(*
let register_service t symbol handler =
  Cyberlogic.db_subscribe_goal t.db (fun goal ->
      let (f, _) = open_literal goal in
      if f = symbol then handler goal else ())
*) 

let connect_to_contract t contract = 
  Log.info("Connecting to contract");
  t.contract <- Some contract;
  Fabric.add_contract_listener contract (claim_event_listener t)
  |> Js.Promise.then_ (fun () -> 
      flush_queue t
    )