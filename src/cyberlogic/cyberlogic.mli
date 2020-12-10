type color =
  | Yellow
  | Green
  | ColorVar of int

module Principal : sig
  type t =
    | Var of int
    | Id of Id.t
    | Undefined (* Neede because we don't have typed terms. It's the 
                   catch-all for non-welltypes values. *)

  type t_json =
    | VarJSON of { var : int }
    | IdJSON of { subject : Id.DN.t_json; issuer: Id.DN.t_json }
    | Undefined

  val to_term : t -> Default.term
end

module Literal : sig

  type t

  type t_json = {
    color : string;
    principal : Principal.t_json;
    literal : string
  }

  val make : Default.symbol -> color -> Principal.t -> Default.term list -> t
  val color : t -> color
  val principal : t -> Principal.t
  val plain_literal : t -> Default.literal

  val to_json : t -> t_json
end

module Clause : sig

  type t

  val make : Literal.t -> Literal.t list -> t
  val head : t -> Literal.t
  val body : t -> Literal.t list
  val is_fact : t -> bool

  val debug_clause : t -> unit

end

type program = {
  clauses : Clause.t list;
  goals : Literal.t list
}

(* Expose interface of bottom-up *)
type db

val db_create : unit -> db
(** Create a DB *)

val db_mem : db -> Clause.t -> bool
(** Is the clause member of the DB? *)

val db_add : ?expl:Default.explanation -> db -> Clause.t -> unit
(** Add the clause/fact to the DB as an axiom, updating fixpoint.
    UnsafeRule will be raised if the rule is not safe (see {!check_safe}) *)

val db_add_fact : ?expl:Default.explanation -> db -> Literal.t -> unit
(** Add a fact (ground unit clause) *)

val db_fold : ('a -> Clause.t -> 'a) -> 'a -> db -> 'a
(** Fold on all clauses in the current DB (including fixpoint) *)

val db_goal : db -> Literal.t -> unit
(** Add a goal to the DB. The goal is used to trigger backward chaining
    (calling goal handlers that could help solve the goal) *)

type fact_handler = Literal.t -> unit
type goal_handler = Literal.t -> unit

val db_subscribe_fact : db -> Default.symbol -> fact_handler -> unit
val db_subscribe_all_facts : db -> fact_handler -> unit
val db_subscribe_goal : db -> goal_handler -> unit

val db_explain : db -> Literal.t -> Literal.t list
(** Explain the given fact by returning a list of facts that imply it
    under the current clauses, or raise Not_found *)

val db_explanations : db -> Clause.t -> Default.explanation list
(** Get all the explanations that explain why this clause is true *)
