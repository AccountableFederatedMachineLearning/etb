
(* this file is part of datalog. See README for the license *)

type location = {
  line : int;
  column : int
}

type file = {
  identities : abbrev list;
  clauses : clause list;
  goals : literal list;
}
and abbrev = string * Id.t
and clause =
  | Clause of literal * attested_literal list
and attested_literal =   
  | Unattested of literal
  | Attested of location * principal * literal
and literal =
  | Atom of string * term list
and principal =
  | PrincipalVar of string
  | PrincipalName of string  
and term =
  | Var of string
  | Const of string
  | Quoted of string
and query =
  | Query of term list * literal list * literal list
  (** Query: projection, positive lits, negative lits *)

