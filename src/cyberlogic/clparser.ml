type token =
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS
  | LEFT_BRACKET
  | RIGHT_BRACKET
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

# 36 "clparser.ml"
let yytransl_const = [|
  257 (* LEFT_PARENTHESIS *);
  258 (* RIGHT_PARENTHESIS *);
  259 (* LEFT_BRACKET *);
  260 (* RIGHT_BRACKET *);
  261 (* DOT *);
  262 (* IF *);
  263 (* NOT *);
  264 (* COMMA *);
  265 (* SAYS *);
  266 (* EQUALS *);
  267 (* COLON *);
  268 (* SUBJECT *);
  269 (* ISSUER *);
  270 (* EOI *);
    0|]

let yytransl_block = [|
  271 (* SINGLE_QUOTED *);
  272 (* LOWER_WORD *);
  273 (* UPPER_WORD *);
  274 (* INT *);
    0|]

let yylhs = "\255\255\
\004\000\001\000\002\000\003\000\005\000\006\000\006\000\012\000\
\007\000\007\000\010\000\010\000\009\000\009\000\008\000\008\000\
\008\000\008\000\011\000\015\000\015\000\015\000\015\000\013\000\
\013\000\016\000\016\000\016\000\016\000\016\000\014\000\000\000\
\000\000\000\000\000\000\000\000"

let yylen = "\002\000\
\003\000\002\000\002\000\002\000\002\000\000\000\002\000\008\000\
\001\000\002\000\002\000\004\000\001\000\003\000\001\000\004\000\
\003\000\006\000\005\000\003\000\004\000\001\000\002\000\001\000\
\003\000\001\000\001\000\001\000\001\000\005\000\001\000\002\000\
\002\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\006\000\000\000\000\000\031\000\000\000\
\032\000\000\000\000\000\033\000\000\000\000\000\034\000\000\000\
\000\000\035\000\000\000\000\000\036\000\000\000\000\000\002\000\
\000\000\000\000\003\000\011\000\000\000\004\000\000\000\000\000\
\000\000\007\000\000\000\029\000\027\000\028\000\026\000\000\000\
\000\000\005\000\000\000\000\000\014\000\000\000\000\000\001\000\
\010\000\000\000\000\000\000\000\016\000\000\000\012\000\000\000\
\000\000\000\000\025\000\000\000\000\000\000\000\000\000\000\000\
\019\000\018\000\000\000\030\000\000\000\000\000\000\000\000\000\
\020\000\000\000\021\000\008\000"

let yydgoto = "\006\000\
\009\000\012\000\015\000\018\000\021\000\019\000\032\000\013\000\
\014\000\033\000\022\000\034\000\040\000\011\000\065\000\041\000"

let yysindex = "\035\000\
\001\255\001\255\001\255\000\000\008\255\000\000\000\000\042\255\
\000\000\030\255\036\255\000\000\038\255\033\255\000\000\025\255\
\034\255\000\000\026\255\004\255\000\000\035\255\004\255\000\000\
\037\255\001\255\000\000\000\000\001\255\000\000\039\255\040\255\
\001\255\000\000\004\255\000\000\000\000\000\000\000\000\049\255\
\044\255\000\000\053\255\055\255\000\000\054\255\046\255\000\000\
\000\000\052\255\057\255\004\255\000\000\004\255\000\000\050\255\
\004\255\252\254\000\000\062\255\051\255\061\255\001\255\059\255\
\000\000\000\000\060\255\000\000\064\255\252\254\063\255\252\254\
\000\000\065\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\
\000\000\000\000\000\000\000\000\010\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\066\255\000\000\
\056\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\074\255\000\000\000\000\020\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\067\255\
\000\000\000\000\000\000\000\000\068\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\044\000\255\255\
\240\255\065\000\000\000\000\000\237\255\000\000\213\255\222\255"

let yytablesize = 82
let yytable = "\010\000\
\050\000\016\000\063\000\043\000\015\000\015\000\035\000\015\000\
\020\000\045\000\007\000\008\000\046\000\015\000\013\000\007\000\
\008\000\016\000\036\000\037\000\038\000\039\000\062\000\013\000\
\017\000\017\000\073\000\017\000\075\000\028\000\029\000\016\000\
\059\000\017\000\060\000\001\000\002\000\003\000\004\000\005\000\
\031\000\008\000\023\000\024\000\025\000\026\000\027\000\030\000\
\042\000\047\000\051\000\052\000\044\000\048\000\053\000\054\000\
\064\000\056\000\055\000\057\000\061\000\069\000\058\000\066\000\
\068\000\067\000\070\000\017\000\064\000\009\000\064\000\072\000\
\071\000\074\000\031\000\024\000\049\000\000\000\000\000\076\000\
\022\000\023\000"

let yycheck = "\001\000\
\035\000\003\000\007\001\023\000\005\001\006\001\003\001\008\001\
\001\001\026\000\015\001\016\001\029\000\014\001\005\001\015\001\
\016\001\019\000\015\001\016\001\017\001\018\001\057\000\014\001\
\005\001\006\001\070\000\008\001\072\000\005\001\006\001\033\000\
\052\000\014\001\054\000\001\000\002\000\003\000\004\000\005\000\
\015\001\016\001\001\001\014\001\009\001\008\001\014\001\014\001\
\014\001\011\001\002\001\008\001\016\001\014\001\002\001\001\001\
\058\000\012\001\005\001\008\001\011\001\063\000\006\001\002\001\
\004\001\015\001\008\001\003\000\070\000\014\001\072\000\008\001\
\013\001\011\001\009\001\002\001\033\000\255\255\255\255\015\001\
\014\001\014\001"

let yynames_const = "\
  LEFT_PARENTHESIS\000\
  RIGHT_PARENTHESIS\000\
  LEFT_BRACKET\000\
  RIGHT_BRACKET\000\
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
# 56 "clparser.mly"
                        ( (_1, _2) )
# 178 "clparser.ml"
               : Clast.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 59 "clparser.mly"
                ( _1 )
# 185 "clparser.ml"
               : Clast.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 62 "clparser.mly"
                 ( _1 )
# 192 "clparser.ml"
               : Clast.literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 65 "clparser.mly"
               ( _1 )
# 199 "clparser.ml"
               : Clast.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 68 "clparser.mly"
              ( _1 )
# 206 "clparser.ml"
               : Clast.query))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "clparser.mly"
                   ( [] )
# 212 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'abbrev) in
    Obj.repr(
# 72 "clparser.mly"
                   ( _2 :: _1 )
# 220 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 76 "clparser.mly"
     ( (without_quotes _1, 
        Id.{ subject = DN.make_exn (without_quotes _5);
             issuer = DN.make_exn (without_quotes _8)
        })
     )
# 233 "clparser.ml"
               : 'abbrev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 83 "clparser.mly"
           ( [_1] )
# 240 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 84 "clparser.mly"
                   ( _1 :: _2 )
# 248 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 87 "clparser.mly"
                ( Clast.Clause (_1, []) )
# 255 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 88 "clparser.mly"
                            ( Clast.Clause (_1, _3) )
# 263 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 91 "clparser.mly"
            ( [_1] )
# 270 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literals) in
    Obj.repr(
# 92 "clparser.mly"
                           ( _1 :: _3 )
# 278 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 95 "clparser.mly"
               ( Clast.Atom (_1, []) )
# 285 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 97 "clparser.mly"
    ( Clast.Atom (_1, _3) )
# 293 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 99 "clparser.mly"
    ( Clast.Attestation (current_location (), _1, _3, []) )
# 301 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 101 "clparser.mly"
    ( Clast.Attestation (current_location (), _1, _3, _5) )
# 310 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'args) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 105 "clparser.mly"
    (
      let pos_literals, neg_literal = _5 in
      Clast.Query (_2, pos_literals, neg_literal)
    )
# 321 "clparser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 112 "clparser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 329 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 114 "clparser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 337 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 115 "clparser.mly"
            ( [_1], [] )
# 344 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 116 "clparser.mly"
                ( [], [_2] )
# 351 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 119 "clparser.mly"
         ( [_1] )
# 358 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 120 "clparser.mly"
                     ( _1 :: _3 )
# 366 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 123 "clparser.mly"
        ( Clast.Const _1 )
# 373 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 124 "clparser.mly"
               ( Clast.Const _1 )
# 380 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 125 "clparser.mly"
               ( Clast.Var _1 )
# 387 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 126 "clparser.mly"
                  ( Clast.Quoted _1 )
# 394 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'term) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'term) in
    Obj.repr(
# 127 "clparser.mly"
                                               ( Clast.Pair (_2, _4) )
# 402 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 130 "clparser.mly"
                  ( without_quotes _1 )
# 409 "clparser.ml"
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
