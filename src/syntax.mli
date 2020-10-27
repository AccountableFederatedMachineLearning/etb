
exception Error of {
    line : int;
    column : int
  }

val parse_literal_exn : string -> Default.literal

val parse_clause_exn : string -> Default.clause

val parse_file_exn : string -> Default.clause list

val string_of_literal : Default.literal -> string

val string_of_clause : Default.clause -> string