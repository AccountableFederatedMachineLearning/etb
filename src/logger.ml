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

