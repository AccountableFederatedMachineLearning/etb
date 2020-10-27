type contract

val connect_to_fabric : unit -> contract Js.Promise.t

val add_contract_listener : contract -> (string -> unit Js.Promise.t) -> unit Js.Promise.t

val log : contract -> string -> unit Js.Promise.t
