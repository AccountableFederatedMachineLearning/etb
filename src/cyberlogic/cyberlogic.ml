open Default

type color =
  | Yellow
  | Green
  | ColorVar of int

type literal = Default.literal
type clause = Default.clause


(** Colors encoded as constant terms *)

let color_term c = 
  let yellow = mk_const (StringSymbol.make "yellow") in
  let green = mk_const (StringSymbol.make "green") in
  match c with 
  | Yellow -> yellow 
  | Green -> green
  | ColorVar i -> mk_var i

let color_from_term c = 
  match c with
  | Var i -> ColorVar i
  | Const _ ->
    if eq_term c (color_term Yellow) then Yellow
    else if eq_term c (color_term Green) then Green
    else failwith "term must be yellow, green or variable"

let is_color_term c =
  ignore (color_from_term c); (* fails if c is not color *)
  true

(** Principals encoded as constant terms *)

let principal_term id = 
  mk_const (StringSymbol.make (Id.to_string id))

let principal_from_term c = 
  match c with
  | Var _ -> failwith "color is variable"
  | Const p -> 
    let s = StringSymbol.to_string p in
    Id.from_string_exn s

(** Literals *)

let mk_open_literal s color_tm principal_tm args =
  Default.mk_literal s (color_tm :: principal_tm :: args)

let mk_literal s color principal args =
  mk_open_literal s (color_term color) (principal_term principal) args

let color literal =
  match open_literal literal with
  | (_, []) -> failwith "literal has no color"
  | (_, (a :: _)) -> color_from_term a

let principal literal =
  match open_literal literal with
  | (_, []) -> failwith "literal has no color"
  | (_, [_]) -> failwith "literal has no princial"
  | (_, (_ :: p :: _)) -> principal_from_term p

let plain_literal literal =
  match open_literal literal with
  | (_, []) 
  | (_, [_]) -> failwith "plain_literal may only be applied to encoded literals"
  | (s, c :: _ :: args) ->
    assert (is_color_term c);
    Default.mk_literal s args

(** Clauses *)

let mk_clause = Default.mk_clause

let head clause = Default.of_soft_lit (fst (Default.open_clause clause))
let body clause = List.map Default.of_soft_lit (snd (Default.open_clause clause))

let is_fact =
  Default.is_fact 

(*
let pretty_string literal =
  let color = match color literal with 
    | Yellow -> "yellow"
    | Green -> "green" in
  let principal = match Id.Name.get (principal literal).subject "CN" with
    | None -> "<unknown>"
    | Some n -> n in
  let claim = Syntax.string_of_literal (plain_literal literal) in
  principal ^ " says " ^ claim ^ " [" ^ color ^ "]"
*)
(* Database *)
type db = Default.db

let db_create = 
  Default.db_create

let db_add =
  Default.db_add

let db_add_fact = 
  Default.db_add_fact

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
