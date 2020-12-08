
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

  val parse_literal_exn : Cyberlogic.principal -> Cyberlogic.color -> string -> Cyberlogic.Literal.t

  val parse_clause_exn : Cyberlogic.principal -> string -> Cyberlogic.Clause.t

  val parse_file_exn : Id.t -> string -> Cyberlogic.Clause.t list

  val short_literal : Cyberlogic.Literal.t -> string

  val short_clause : Cyberlogic.Clause.t -> string

end 