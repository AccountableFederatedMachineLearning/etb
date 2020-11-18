val debug : 'a -> unit
val info : 'a -> unit

val fdebug : ('a -> 'b, unit, string) format -> 'a -> unit
val finfo : ('a -> 'b, unit, string) format -> 'a -> unit
