
type t

val create : Id.t -> Cyberlogic.Clause.t list -> t

val add_fact : t -> Default.literal -> unit Js.Promise.t

val all_facts : t -> Cyberlogic.Clause.t list

val goal : t -> Default.literal -> unit Js.Promise.t

(* Register a local service *)
(*
val register_service : t -> Default.symbol -> (Default.literal -> unit) -> unit
*)

val connect_to_contract : t -> Fabric.contract -> unit Js.Promise.t

val add_fact_listener : t -> (Cyberlogic.Literal.t -> unit Js.Promise.t) -> unit
