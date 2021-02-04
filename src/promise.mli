(** Monadic operations for promises to simplify notation *)

val pure : 'a  -> 'a Js.Promise.t

val (>>=) : 'a Js.Promise.t -> ('a -> 'b Js.Promise.t) -> 'b Js.Promise.t

val (<*>) : ('a -> 'b) Js.Promise.t -> 'a Js.Promise.t -> 'b Js.Promise.t

val wait : int -> unit Js.Promise.t 
