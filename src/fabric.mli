type contract

val user_certificate : unit -> string Js.Promise.t

val connect : unit -> contract Js.Promise.t

val add_contract_listener 
  : contract -> (string -> unit Js.Promise.t) -> unit Js.Promise.t

val add_claim : contract -> string -> unit Js.Promise.t
