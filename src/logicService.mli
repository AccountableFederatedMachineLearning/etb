
type t

val create : Default.clause list -> Id.t -> t

val add_fact : t -> Default.literal -> unit Js.Promise.t

val all_facts : t -> Cyberlogic.clause list

(* Register a local service *)
(*
val register_service : t -> Default.symbol -> (Default.literal -> unit) -> unit
*)

val connect_to_contract : t -> Fabric.contract -> unit Js.Promise.t
