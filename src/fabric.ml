type contract

external user_certificate : unit -> string Js.Promise.t = 
  "getUserCertificate" [@@bs.module("./fabric.js")]

external connect : unit -> contract Js.Promise.t = 
  "connect" [@@bs.module("./fabric.js")]

external add_contract_listener 
  : contract -> (string -> string -> unit Js.Promise.t) -> unit Js.Promise.t = 
  "addContractListener" [@@bs.module("./fabric.js")]

external add_claim : contract -> string -> unit Js.Promise.t = 
  "addClaim" [@@bs.module("./fabric.js")]
