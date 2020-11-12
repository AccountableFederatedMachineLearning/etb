type color =
  | Yellow
  | Green
  | ColorVar of int

module Literal : sig

  type t

  type t_json = {
    color : string;
    principal : Id.t_json;
    literal : string
  }

  val make : Default.symbol -> color -> Id.t -> Default.term list -> t
  val color : t -> color
  val principal : t -> Id.t
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

val db_explanations : db -> Clause.t -> Default.explanation list
(** Get all the explanations that explain why this clause is true *)
