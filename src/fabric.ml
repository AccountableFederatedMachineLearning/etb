type contract

external user_certificate : unit -> string Js.Promise.t = "getUserCertificate" [@@bs.module("./fabric.js")]

external connect : unit -> contract Js.Promise.t = "connect" [@@bs.module("./fabric.js")]

external add_contract_listener : contract -> (string -> unit Js.Promise.t) -> unit Js.Promise.t = "addContractListener" [@@bs.module("./fabric.js")]

external log : contract -> string -> unit Js.Promise.t = "log" [@@bs.module("./fabric.js")]
