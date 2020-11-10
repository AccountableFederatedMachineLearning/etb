type color =
  | Yellow
  | Green
  | ColorVar of int

type literal
type clause

val mk_literal : Default.symbol -> color -> Id.t -> Default.term list -> literal
val color : literal -> color
val principal : literal -> Id.t
val plain_literal : literal -> Default.literal

val mk_clause : literal -> literal list -> clause
val head : clause -> literal
val body : clause -> literal list
val is_fact : clause -> bool

(* Expose interface of bottom-up *)
type db

val db_create : unit -> db
(** Create a DB *)

val db_add : ?expl:Default.explanation -> db -> clause -> unit
(** Add the clause/fact to the DB as an axiom, updating fixpoint.
    UnsafeRule will be raised if the rule is not safe (see {!check_safe}) *)

val db_add_fact : ?expl:Default.explanation -> db -> literal -> unit
(** Add a fact (ground unit clause) *)

val db_fold : ('a -> clause -> 'a) -> 'a -> db -> 'a
(** Fold on all clauses in the current DB (including fixpoint) *)

type fact_handler = literal -> unit
type goal_handler = literal -> unit

val db_subscribe_fact : db -> Default.symbol -> fact_handler -> unit
val db_subscribe_all_facts : db -> fact_handler -> unit
val db_subscribe_goal : db -> goal_handler -> unit
