type contract

external connect_to_fabric : unit -> contract Js.Promise.t = "connect" [@@bs.module("./fabric.js")]

external add_contract_listener : contract -> (string -> unit Js.Promise.t) -> unit Js.Promise.t = "addContractListener" [@@bs.module("./fabric.js")]

external log : contract -> string -> unit Js.Promise.t = "log" [@@bs.module("./fabric.js")]

module Log = struct
  let trace x = Js.Console.log("[trace] " ^ (Js.String.make x))
  let info x = Js.Console.info("[info] " ^ (Js.String.make x))
end

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

let pp_to_string pp x : string =
  pp Format.str_formatter x;
  Format.flush_str_formatter ()


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

  module Syntax = struct

    let yellow : term = mk_const (StringSymbol.make "yellow")

    let green : term = mk_const (StringSymbol.make "green")

    let extend soft_literal arg =
      let (s, args) = soft_literal in
      mk_literal s (arg::args)

    let color soft_literal =
      match soft_literal with
      | _, [] -> failwith "literal has no color"
      | _, (a :: _) -> 
        assert (eq_term a yellow || eq_term a green);
        a

    let extend_green clause =
      let (head, body) = open_clause clause in
      let green_head = extend head green in
      let green_args = List.map (fun a -> extend a green) body in
      mk_clause green_head green_args

    let extend_yellow clause =
      let (head, body) = open_clause clause in
      let yellow_head = extend head yellow in
      let yellow_args = List.mapi (fun i (s, args) -> 
          mk_literal s (mk_var (-i-1) :: args)) body in
      mk_clause yellow_head yellow_args

  end  

  let add_clause t clause =
    let yellow_clause = Syntax.extend_yellow clause in
    let green_clause = Syntax.extend_yellow clause in
    Log.trace(pp_to_string pp_clause yellow_clause ^ "\n");
    Log.trace(pp_to_string pp_clause green_clause ^ "\n");
    db_add t.db yellow_clause;
    db_add t.db green_clause

  let create prg = 
    let t = {
      db = Default.db_create ();
      log_queue = []
    } in

    let fact_handler (fact : literal) : unit =
      let color = Syntax.color (open_literal fact) in
      if (eq_term color Syntax.green) then (
        let fact_string = pp_to_string pp_literal fact in
        Log.trace("queueing " ^ fact_string);
        t.log_queue <- fact_string :: t.log_queue
      ) in

    db_subscribe_all_facts t.db fact_handler;

    List.iter (add_clause t) prg;
    t

  let add_fact t fact =
    Default.db_add_fact t.db fact

  let register_service t symbol handler =
    Default.db_subscribe_goal t.db (fun goal ->
        let (f, _) = open_literal goal in
        if f = symbol then handler goal else ())

  let connect_to_contract t contract = 
    Log.info("Connecting to contract");
    (* Probably want to synchronize here *)

    (* Log all messages (without order) *)
    let rec write_queue () =
      let messages = t.log_queue in
      t.log_queue <- [];
      let log m = Log.trace("logging " ^ m); log contract m in      
      Js.Promise.all (messages |> List.map log |> Array.of_list)
      |> Js.Promise.then_ (fun _ -> Js.Promise.resolve ()) in

    let listener (s: string): unit Js.Promise.t =
      Log.trace("receiving fact '" ^ s ^ "'");
      try
        let c = parse_literal s in
        db_add_fact t.db c
      with Parsing.Parse_error ->
        Log.trace("Parse error when adding '" ^ s ^ "'");       ;
        (* Don't need to log the message that we've just received. *)
        t.log_queue <- List.filter (fun m -> m <> s) t.log_queue;
        write_queue () in

    add_contract_listener contract listener 
    |> Js.Promise.then_ write_queue

end

let main prg = 
  let clauses = parse_file prg in
  connect_to_fabric () 
  |> Js.Promise.then_ (
    ETB.create clauses
    |> ETB.connect_to_contract)