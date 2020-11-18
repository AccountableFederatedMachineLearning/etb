module Format = BsWinston.Format
module Transport = BsWinston.Transport

let logger =
  BsWinston.Builder.(
    create ()
    |. setLevel Debug
    |. addFormat(Format.createCli())
    |. addTransport(Transport.createConsole(()))
    |. build
  )

module L = BsWinston.Logger

let debug x = L.logDebugMsg logger (Js.String.make x) 
let info x = L.logInfoMsg logger (Js.String.make x) 

let fdebug f x = debug (Printf.sprintf f x)
let finfo f x = info (Printf.sprintf f x)

(*
(** Bind to fabric's logger *)

type fabric_logger
external get_logger : string -> fabric_logger = "getLogger" [@@bs.module("fabric-client")]
external log_info : fabric_logger -> string -> 'a array -> unit = "info" [@@bs.send] [@@bs.variadic] 
external log_debug : fabric_logger -> string -> 'a array -> unit = "debug" [@@bs.send] [@@bs.variadic] 

let logger = get_logger "evidentia"

let debug x =  log_debug logger "%s" [| Js.String.make x |]
let info x = log_info logger "%s" [| Js.String.make x |]

let debug1 msg x =  log_debug logger msg [| Js.String.make x |]
*)
