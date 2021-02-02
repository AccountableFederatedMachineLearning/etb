open Default

type transaction_id = string

type color =
  | Yellow
  | Green of transaction_id
  | ColorVar of int

(** Colors encoded as constant terms *)

let color_term c = 
  let yellow = mk_const (StringSymbol.make "yellow") in
  let green tid = mk_const (StringSymbol.make ("green:" ^ tid)) in
  match c with 
  | Yellow -> yellow 
  | Green tid -> green tid
  | ColorVar i -> mk_var i

let color_from_term c = 
  match c with
  | Var i -> ColorVar i
  | Const sym ->
    let s = Default.StringSymbol.to_string sym in
    if s = "yellow" then Yellow
    else match String.split_on_char ':' s with
      | ["green"; tid] -> Green tid
      | _ -> failwith "term must be yellow, green or variable"

let is_color_term c =
  ignore (color_from_term c); (* fails if c is not color *)
  true

(** Principals encoded as constant terms *)

module Principal = struct
  type t =
    | Var of int
    | Id of Id.t
    | Undefined

  type t_json =
    | VarJSON of { var : int }
    | IdJSON of { subject : Id.DN.t_json; issuer: Id.DN.t_json }
    | Undefined

  let to_term p = 
    match p with 
    | Var i -> mk_var i
    | Id id -> mk_const (StringSymbol.make (Id.to_string id))
    | Undefined -> mk_const (StringSymbol.make "<undefined>")

  let from_term c = 
    match c with
    | Default.Var i -> Var i
    | Const p -> 
      try
        let s = StringSymbol.to_string p in
        Id (Id.from_string_exn s)
      with _ -> 
        Undefined

  let to_json p = 
    match p with 
    | Var i -> VarJSON { var = i }
    | Id id -> IdJSON { subject = Id.DN.to_json id.subject;
                        issuer = Id.DN.to_json id.issuer }
    | Undefined -> Undefined

  let equals p q = 
    match p, q with
    | Var i, Var j -> i = j
    | Id i, Id j -> Id.equals i j
    | Undefined, Undefined -> true
    | _ -> false
end
(** Literals *)

module Literal = struct

  type t = Default.literal

  type t_json = {
    color : string;
    transaction : string option;
    principal : Principal.t_json;
    literal : literal_json
  } and literal_json = {
    symbol : string;
    arguments : string Js.Array.t 
  }

  let make s color principal args =
    Default.mk_literal s 
      (color_term color :: Principal.to_term principal :: args)

  let color literal =
    match open_literal literal with
    | (_, []) -> failwith "literal has no color"
    | (_, (a :: _)) -> color_from_term a

  let principal literal =
    match open_literal literal with
    | (_, []) -> failwith "literal has no color"
    | (_, [_]) -> failwith "literal has no princial"
    | (_, (_ :: p :: _)) -> Principal.from_term p

  let plain_literal literal =
    match open_literal literal with
    | (_, []) 
    | (_, [_]) -> failwith "plain_literal may only be applied to encoded literals"
    | (s, c :: _ :: args) ->
      assert (is_color_term c);
      Default.mk_literal s args

  let to_json literal = {
    color = 
      begin
        match color literal with
        | Yellow -> "yellow"
        | Green _ -> "green"
        | ColorVar i -> "X" ^ (string_of_int i)
      end;
    transaction = 
      begin
        match color literal with
        | Green tid -> Some tid
        | _ -> None
      end;
    principal = Principal.to_json (principal literal);
    literal =
      let p = plain_literal literal in
      let (sym, args) = Default.open_literal p in
      { symbol = StringSymbol.to_string sym;
        arguments = Array.of_list (List.map (fun arg ->
            Default.pp_term Format.str_formatter arg;
            Format.flush_str_formatter ()
          ) args)
      }
  }

end

(** Clauses *)

module Clause = struct 

  type t = Default.clause

  let make = Default.mk_clause

  let head clause = Default.of_soft_lit (fst (Default.open_clause clause))
  let body clause = List.map Default.of_soft_lit (snd (Default.open_clause clause))

  let is_fact =
    Default.is_fact

  let debug_clause clause =
    pp_clause Format.str_formatter clause;
    Js.Console.log(Format.flush_str_formatter ())

end

type program = {
  clauses : Clause.t list;
  goals : Literal.t list
}

(* Database *)
type db = Default.db

let db_create = 
  Default.db_create

let db_mem =
  Default.db_mem

let db_add =
  Default.db_add

let db_add_fact = 
  Default.db_add_fact

let db_goal = 
  Default.db_goal

let db_fold =
  Default.db_fold

type fact_handler = literal -> unit
type goal_handler = literal -> unit

let db_subscribe_fact =
  Default.db_subscribe_fact

let db_subscribe_all_facts =
  Default.db_subscribe_all_facts

let db_subscribe_goal =
  Default.db_subscribe_goal

let db_premises =
  Default.db_premises

let db_explain =
  Default.db_explain

let db_explanations =
  Default.db_explanations