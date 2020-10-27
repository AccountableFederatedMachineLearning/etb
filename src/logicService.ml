
open Default

module Log = struct
  let trace x = Js.Console.log("[trace] " ^ (Js.String.make x))
  let info x = Js.Console.info("[info] " ^ (Js.String.make x))
end

let pp_to_string pp x : string =
  pp Format.str_formatter x;
  Format.flush_str_formatter ()

(** State of the logic service *)
type t = {
  db : Default.db;
  mutable contract : Fabric.contract option;
  mutable log_queue : string list
}

type color =
  | Yellow
  | Green

module Syntax = struct

  let const_of_color c = 
    let yellow = mk_const (StringSymbol.make "yellow") in
    let green = mk_const (StringSymbol.make "green") in
    match c with 
    | Yellow -> yellow 
    | Green -> green

  let color_of_const c = 
    if eq_term c (const_of_color Yellow) then Yellow
    else if eq_term c (const_of_color Green) then Green
    else failwith "term must be yellow or green"

  let is_color_const c =
    ignore (color_of_const c); (* fails if c is not color *)
    true

  let extend soft_literal arg =
    let (s, args) = soft_literal in
    mk_literal s (arg::args)

  let color_of_literal literal =
    match open_literal literal with
    | _, [] -> failwith "literal has no color"
    | _, (a :: _) -> color_of_const a

  let extend_literal fact color =
    let (s, args) = open_literal fact in
    mk_literal s (const_of_color color :: args)

  let make_green fact =
    let (s, args) = open_literal fact in
    match args with
    | [] -> failwith "literal has no color"
    | c :: rest ->
      assert (is_color_const c);
      mk_literal s (const_of_color Green :: rest)

  let extend_clause clause =
    let (head, body) = open_clause clause in
    let yellow_head = extend head (const_of_color Yellow) in
    let any_args = List.mapi (fun i (s, args) -> 
        mk_literal s (mk_var (-i-1) :: args)) body in
    mk_clause yellow_head any_args
end  

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

let add_fact t fact =  
  let yellow_fact = Syntax.extend_literal fact Yellow in
  Default.db_add_fact t.db yellow_fact;
  flush_queue t

let add_clause t clause =
  let extended_clause = Syntax.extend_clause clause in
  Log.trace(pp_to_string pp_clause extended_clause);
  db_add t.db extended_clause

let create prg = 
  let t = {
    db = Default.db_create ();
    contract = None;
    log_queue = []
  } in

  let fact_handler (fact : literal) : unit =
    Log.trace("fact handler for " ^ (pp_to_string pp_literal fact));
    if (Syntax.color_of_literal fact = Yellow) then (
      let green_fact = Syntax.make_green fact in
      let green_fact_string = pp_to_string pp_literal green_fact in
      Log.trace("queueing " ^ green_fact_string);
      t.log_queue <- green_fact_string :: t.log_queue
    ) in

  db_subscribe_all_facts t.db fact_handler;

  List.iter (add_clause t) prg;
  t

let register_service t symbol handler =
  Default.db_subscribe_goal t.db (fun goal ->
      let (f, _) = open_literal goal in
      if f = symbol then handler goal else ())

let connect_to_contract t contract = 
  Log.info("Connecting to contract");
  (* Probably want to synchronize here *)
  t.contract <- Some contract;

  let listener (s: string): unit Js.Promise.t =
    Log.trace("receiving fact '" ^ s ^ "'");
    try
      let c = DatalogParser.literal_exn s in
      db_add_fact t.db c
    with Parsing.Parse_error ->
      Log.trace("Parse error when adding '" ^ s ^ "'");       ;
      (* Don't need to log the message that we've just received. *)
      t.log_queue <- List.filter (fun m -> m <> s) t.log_queue;
      flush_queue t in

  Fabric.add_contract_listener contract listener 
  |> Js.Promise.then_ (fun () -> 
      flush_queue t
    )