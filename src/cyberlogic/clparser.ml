type token =
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS
  | DOT
  | IF
  | NOT
  | COMMA
  | SAYS
  | EQUALS
  | COLON
  | SUBJECT
  | ISSUER
  | EOI
  | SINGLE_QUOTED of (string)
  | LOWER_WORD of (string)
  | UPPER_WORD of (string)
  | INT of (string)

open Parsing;;
let _ = parse_error;;
# 6 "clparser.mly"
  let without_quotes quoted =
    String.sub quoted 1 (String.length quoted - 2)

  let location_of_pos pos =
    let open Lexing in
    { Clast.line = pos.pos_lnum;
      Clast.column = pos.pos_cnum - pos.pos_bol + 1 }

  let current_location () =
    location_of_pos (Parsing.symbol_start_pos ())

# 34 "clparser.ml"
let yytransl_const = [|
  257 (* LEFT_PARENTHESIS *);
  258 (* RIGHT_PARENTHESIS *);
  259 (* DOT *);
  260 (* IF *);
  261 (* NOT *);
  262 (* COMMA *);
  263 (* SAYS *);
  264 (* EQUALS *);
  265 (* COLON *);
  266 (* SUBJECT *);
  267 (* ISSUER *);
  268 (* EOI *);
    0|]

let yytransl_block = [|
  269 (* SINGLE_QUOTED *);
  270 (* LOWER_WORD *);
  271 (* UPPER_WORD *);
  272 (* INT *);
    0|]

let yylhs = "\255\255\
\004\000\001\000\002\000\003\000\005\000\006\000\006\000\012\000\
\007\000\007\000\010\000\010\000\009\000\009\000\008\000\008\000\
\008\000\008\000\011\000\015\000\015\000\015\000\015\000\013\000\
\013\000\016\000\016\000\016\000\016\000\014\000\000\000\000\000\
\000\000\000\000\000\000"

let yylen = "\002\000\
\003\000\002\000\002\000\002\000\002\000\000\000\002\000\008\000\
\001\000\002\000\002\000\004\000\001\000\003\000\001\000\004\000\
\003\000\006\000\005\000\003\000\004\000\001\000\002\000\001\000\
\003\000\001\000\001\000\001\000\001\000\001\000\002\000\002\000\
\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\006\000\000\000\000\000\030\000\000\000\
\031\000\000\000\000\000\032\000\000\000\000\000\033\000\000\000\
\000\000\034\000\000\000\000\000\035\000\000\000\000\000\002\000\
\000\000\000\000\003\000\011\000\000\000\004\000\000\000\000\000\
\000\000\007\000\029\000\027\000\028\000\026\000\000\000\000\000\
\005\000\000\000\000\000\014\000\000\000\000\000\001\000\010\000\
\000\000\000\000\016\000\000\000\012\000\000\000\000\000\025\000\
\000\000\000\000\000\000\000\000\019\000\018\000\000\000\000\000\
\000\000\000\000\000\000\020\000\000\000\021\000\008\000"

let yydgoto = "\006\000\
\009\000\012\000\015\000\018\000\021\000\019\000\032\000\013\000\
\014\000\033\000\022\000\034\000\039\000\011\000\061\000\040\000"

let yysindex = "\020\000\
\013\255\013\255\013\255\000\000\008\255\000\000\000\000\016\255\
\000\000\017\255\024\255\000\000\037\255\032\255\000\000\035\255\
\033\255\000\000\028\255\020\255\000\000\034\255\020\255\000\000\
\036\255\013\255\000\000\000\000\013\255\000\000\038\255\039\255\
\013\255\000\000\000\000\000\000\000\000\000\000\046\255\043\255\
\000\000\050\255\052\255\000\000\053\255\045\255\000\000\000\000\
\055\255\020\255\000\000\020\255\000\000\048\255\006\255\000\000\
\058\255\049\255\013\255\057\255\000\000\000\000\054\255\061\255\
\006\255\059\255\006\255\000\000\056\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\
\000\000\000\000\000\000\000\000\002\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\063\255\000\000\
\060\255\000\000\000\000\000\000\000\000\000\000\000\000\069\255\
\000\000\000\000\004\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\062\255\000\000\000\000\000\000\064\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\028\000\255\255\
\011\000\070\000\000\000\000\000\234\255\000\000\204\255\000\000"

let yytablesize = 76
let yytable = "\010\000\
\042\000\016\000\015\000\015\000\013\000\015\000\017\000\017\000\
\020\000\017\000\059\000\015\000\068\000\013\000\070\000\017\000\
\023\000\016\000\007\000\008\000\001\000\002\000\003\000\004\000\
\005\000\007\000\008\000\056\000\024\000\057\000\025\000\016\000\
\035\000\036\000\037\000\038\000\044\000\028\000\029\000\045\000\
\031\000\008\000\026\000\027\000\030\000\041\000\046\000\049\000\
\050\000\043\000\047\000\051\000\052\000\060\000\054\000\053\000\
\058\000\064\000\055\000\062\000\048\000\063\000\065\000\060\000\
\066\000\060\000\067\000\069\000\071\000\030\000\024\000\009\000\
\017\000\022\000\000\000\023\000"

let yycheck = "\001\000\
\023\000\003\000\003\001\004\001\003\001\006\001\003\001\004\001\
\001\001\006\001\005\001\012\001\065\000\012\001\067\000\012\001\
\001\001\019\000\013\001\014\001\001\000\002\000\003\000\004\000\
\005\000\013\001\014\001\050\000\012\001\052\000\007\001\033\000\
\013\001\014\001\015\001\016\001\026\000\003\001\004\001\029\000\
\013\001\014\001\006\001\012\001\012\001\012\001\009\001\002\001\
\006\001\014\001\012\001\002\001\001\001\055\000\010\001\003\001\
\009\001\059\000\004\001\002\001\033\000\013\001\006\001\065\000\
\011\001\067\000\006\001\009\001\013\001\007\001\002\001\012\001\
\003\000\012\001\255\255\012\001"

let yynames_const = "\
  LEFT_PARENTHESIS\000\
  RIGHT_PARENTHESIS\000\
  DOT\000\
  IF\000\
  NOT\000\
  COMMA\000\
  SAYS\000\
  EQUALS\000\
  COLON\000\
  SUBJECT\000\
  ISSUER\000\
  EOI\000\
  "

let yynames_block = "\
  SINGLE_QUOTED\000\
  LOWER_WORD\000\
  UPPER_WORD\000\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'clauses) in
    Obj.repr(
# 54 "clparser.mly"
                        ( (_1, _2) )
# 167 "clparser.ml"
               : Clast.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 57 "clparser.mly"
                ( _1 )
# 174 "clparser.ml"
               : Clast.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 60 "clparser.mly"
                 ( _1 )
# 181 "clparser.ml"
               : Clast.literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 63 "clparser.mly"
               ( _1 )
# 188 "clparser.ml"
               : Clast.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 66 "clparser.mly"
              ( _1 )
# 195 "clparser.ml"
               : Clast.query))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "clparser.mly"
                   ( [] )
# 201 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'abbrev) in
    Obj.repr(
# 70 "clparser.mly"
                   ( _2 :: _1 )
# 209 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 74 "clparser.mly"
     ( (without_quotes _1, 
        Id.{ subject = Name.make_exn (without_quotes _5);
             issuer = Name.make_exn (without_quotes _8)
        })
     )
# 222 "clparser.ml"
               : 'abbrev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 81 "clparser.mly"
           ( [_1] )
# 229 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 82 "clparser.mly"
                   ( _1 :: _2 )
# 237 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 85 "clparser.mly"
                ( Clast.Clause (_1, []) )
# 244 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 86 "clparser.mly"
                            ( Clast.Clause (_1, _3) )
# 252 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 89 "clparser.mly"
            ( [_1] )
# 259 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literals) in
    Obj.repr(
# 90 "clparser.mly"
                           ( _1 :: _3 )
# 267 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 93 "clparser.mly"
               ( Clast.Atom (_1, []) )
# 274 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 95 "clparser.mly"
    ( Clast.Atom (_1, _3) )
# 282 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 97 "clparser.mly"
    ( Clast.Attestation (current_location (), _1, _3, []) )
# 290 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 99 "clparser.mly"
    ( Clast.Attestation (current_location (), _1, _3, _5) )
# 299 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'args) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 103 "clparser.mly"
    (
      let pos_literals, neg_literal = _5 in
      Clast.Query (_2, pos_literals, neg_literal)
    )
# 310 "clparser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 110 "clparser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 318 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 112 "clparser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 326 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 113 "clparser.mly"
            ( [_1], [] )
# 333 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 114 "clparser.mly"
                ( [], [_2] )
# 340 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 117 "clparser.mly"
         ( [_1] )
# 347 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 118 "clparser.mly"
                     ( _1 :: _3 )
# 355 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 121 "clparser.mly"
        ( Clast.Const _1 )
# 362 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 122 "clparser.mly"
               ( Clast.Const _1 )
# 369 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 123 "clparser.mly"
               ( Clast.Var _1 )
# 376 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 124 "clparser.mly"
                  ( Clast.Quoted _1 )
# 383 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 127 "clparser.mly"
                  ( without_quotes _1 )
# 390 "clparser.ml"
               : 'principal))
(* Entry parse_literal *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry parse_literals *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry parse_clause *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry parse_file *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry parse_query *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let parse_literal (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Clast.literal)
let parse_literals (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : Clast.literal list)
let parse_clause (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 3 lexfun lexbuf : Clast.clause)
let parse_file (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 4 lexfun lexbuf : Clast.file)
let parse_query (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 5 lexfun lexbuf : Clast.query)
