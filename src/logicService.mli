type t

val create : Default.clause list -> t

val add_fact : t -> Default.literal -> unit Js.Promise.t

val all_facts : t -> Default.clause list

(* Register a local service *)
val register_service : t -> Default.symbol -> (Default.literal -> unit) -> unit

val connect_to_contract : t -> Fabric.contract -> unit Js.Promise.t
