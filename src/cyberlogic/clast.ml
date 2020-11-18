
(* this file is part of datalog. See README for the license *)

type location = {
  line : int;
  column : int
}

(** {1 Parsing AST} *)
type file = abbrev list * clause list
and abbrev = string * Id.t
and clause =
  | Clause of literal * literal list
and literal =
  | Atom of string * term list
  | Attestation of location * string * string * term list
and term =
  | Var of string
  | Const of string
  | Quoted of string
  | Pair of term * term  
and query =
  | Query of term list * literal list * literal list

(* TODO: negation in body *)
