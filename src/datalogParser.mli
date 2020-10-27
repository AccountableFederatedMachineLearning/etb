
exception Error of {
    line : int;
    column : int
  }

val literal_exn : string -> Default.literal

val clause_exn : string -> Default.clause

val file_exn : string -> Default.clause list