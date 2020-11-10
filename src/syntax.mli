
exception Error of {
    line : int;
    column : int;
    msg : string
  }

module Datalog : sig

  val parse_literal_exn : string -> Default.literal

  val parse_clause_exn : string -> Default.clause

  val parse_file_exn : string -> Default.clause list

  val string_of_literal : Default.literal -> string

  val string_of_clause : Default.clause -> string

end

module Cyberlogic : sig

  val parse_literal_exn : Id.t -> Cyberlogic.color -> string -> Cyberlogic.literal

  val parse_clause_exn : Id.t -> string -> Cyberlogic.clause

  val parse_file_exn : Id.t -> string -> Cyberlogic.clause list

  val short_literal : Cyberlogic.literal -> string

  val short_clause : Cyberlogic.clause -> string

end 