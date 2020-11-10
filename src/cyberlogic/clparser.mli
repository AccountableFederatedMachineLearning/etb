type token =
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS
  | DOT
  | IF
  | NOT
  | COMMA
  | SAYS
  | EQUALS
  | EOI
  | SINGLE_QUOTED of (string)
  | LOWER_WORD of (string)
  | UPPER_WORD of (string)
  | INT of (string)

val parse_literal :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Clast.literal
val parse_literals :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Clast.literal list
val parse_clause :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Clast.clause
val parse_file :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Clast.file
val parse_query :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Clast.query
