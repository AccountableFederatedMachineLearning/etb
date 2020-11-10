
(* this file is part of datalog. See README for the license *)

type file = abbrev list * clause list
and abbrev = string * string
and clause =
  | Clause of literal * literal list
and literal =
  | Atom of string * term list
  | Attestation of string * string * term list
and term =
  | Var of string
  | Const of string
  | Quoted of string
and query =
  | Query of term list * literal list * literal list
  (** Query: projection, positive lits, negative lits *)

