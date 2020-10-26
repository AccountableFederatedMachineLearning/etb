type contract

external connect_to_fabric : unit -> contract Js.Promise.t = "connect" [@@bs.module("./fabric.js")]

external add_contract_listener : contract -> (string -> unit Js.Promise.t) -> unit Js.Promise.t = "addContractListener" [@@bs.module("./fabric.js")]

external log : contract -> string -> unit Js.Promise.t = "log" [@@bs.module("./fabric.js")]


let parse_literal s =
  let lex = Lexing.from_string s in
  let ac = Parser.parse_literal Lexer.token lex in
  Default.literal_of_ast(ac)

let parse_clause s =
  let lex = Lexing.from_string s in
  let ac = Parser.parse_clause Lexer.token lex in
  Default.clause_of_ast(ac)

let parse_file s =
  let lex = Lexing.from_string s in
  let ac = Parser.parse_file Lexer.token lex in
  List.map Default.clause_of_ast ac

(* Registration of node, remote queries. *)
module Query = struct

  (* Remote service discovery and connection
  val connect_to_contract : t -> contract -> unit Js.Promise.t
  *)
end

(* Logical core, responsible for deriving and logging facts *)
module ETB : sig
  type t

  val create : Default.clause list -> t

  val add_fact: t -> Default.literal -> unit

  (* Register a local service *)
  val register_service: t -> Default.symbol -> (Default.literal -> unit) -> unit

(*
  val rm_service: t -> string -> unit

  (* Should also look for remote services. *)
  val query: t -> Default.literal -> Default.literal

  val await: t -> Default.literal -> unit Js.Promise.t
*)
  val connect_to_contract : t -> contract -> unit Js.Promise.t

end = struct

  open Default

  type t = {
    db : Default.db;
    mutable log_queue : string list
  }

  let create prg = 
    let t = {
      db = Default.db_create ();
      log_queue = []
    } in

    List.iter (db_add t.db) prg;
    t

  let add_fact t fact =
    Default.db_add_fact t.db fact

  let register_service t symbol handler =
    Default.db_subscribe_goal t.db (fun goal ->
      let (f, _) = open_literal goal in
      if f = symbol then handler goal else ())

  let connect_to_contract t contract = 
    Js.log("start");
    (* Probably want to synchronize here *)

    let fact_handler (fact : literal) : unit =       
      pp_literal Format.str_formatter fact;
      let fact_string = Format.flush_str_formatter () in
      Js.log("queueing " ^ fact_string);
      t.log_queue <- fact_string :: t.log_queue in

    db_subscribe_all_facts t.db fact_handler;

    (* Log all messages (without order) *)
    let rec write_queue () =
      let log m = Js.log("logging " ^ m); log contract m in
      Js.Promise.all (t.log_queue |> List.map log |> Array.of_list)
      |> Js.Promise.then_ (fun _ -> Js.Promise.resolve ()) in

    let listener (s: string): unit Js.Promise.t =
      let c = parse_literal s in
      Js.log("adding fact " ^ s);
      db_add_fact t.db c;
      (* Don't need to log the message that we've just received. *)
      t.log_queue <- List.filter (fun m -> m <> s) t.log_queue;
      write_queue () in

    add_contract_listener contract listener 
    |> Js.Promise.then_ write_queue

end

let main prg = 
  Js.log(prg);
  let clauses = parse_file prg in
  connect_to_fabric () 
  |> Js.Promise.then_ (
    ETB.create clauses
    |> ETB.connect_to_contract)