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
\013\000\016\000\016\000\016\000\016\000\014\000\014\000\000\000\
\000\000\000\000\000\000\000\000"

let yylen = "\002\000\
\003\000\002\000\002\000\002\000\002\000\000\000\002\000\008\000\
\001\000\002\000\002\000\004\000\001\000\003\000\001\000\004\000\
\003\000\006\000\005\000\003\000\004\000\001\000\002\000\001\000\
\003\000\001\000\001\000\001\000\001\000\001\000\001\000\002\000\
\002\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\006\000\000\000\000\000\031\000\000\000\
\030\000\032\000\000\000\000\000\033\000\000\000\000\000\034\000\
\000\000\000\000\035\000\000\000\000\000\036\000\000\000\000\000\
\002\000\000\000\000\000\003\000\011\000\000\000\004\000\000\000\
\000\000\000\000\007\000\029\000\027\000\028\000\026\000\000\000\
\000\000\005\000\000\000\000\000\014\000\000\000\000\000\001\000\
\010\000\000\000\000\000\016\000\000\000\012\000\000\000\000\000\
\025\000\000\000\000\000\000\000\000\000\019\000\018\000\000\000\
\000\000\000\000\000\000\000\000\020\000\000\000\021\000\008\000"

let yydgoto = "\006\000\
\010\000\013\000\016\000\019\000\022\000\020\000\033\000\014\000\
\015\000\034\000\023\000\035\000\040\000\012\000\062\000\041\000"

let yysindex = "\033\000\
\024\255\024\255\024\255\000\000\003\255\000\000\000\000\008\255\
\000\000\000\000\015\255\036\255\000\000\038\255\033\255\000\000\
\026\255\034\255\000\000\027\255\005\255\000\000\035\255\005\255\
\000\000\037\255\024\255\000\000\000\000\024\255\000\000\039\255\
\040\255\024\255\000\000\000\000\000\000\000\000\000\000\049\255\
\044\255\000\000\054\255\056\255\000\000\053\255\048\255\000\000\
\000\000\055\255\005\255\000\000\005\255\000\000\051\255\252\254\
\000\000\061\255\057\255\024\255\058\255\000\000\000\000\060\255\
\062\255\252\254\063\255\252\254\000\000\064\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\
\000\000\000\000\000\000\000\000\000\000\012\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\059\255\
\000\000\050\255\000\000\000\000\000\000\000\000\000\000\000\000\
\067\255\000\000\000\000\010\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\066\255\000\000\000\000\000\000\
\068\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\037\000\255\255\
\236\255\072\000\000\000\000\000\233\255\000\000\215\255\000\000"

let yytablesize = 82
let yytable = "\011\000\
\043\000\017\000\060\000\021\000\015\000\015\000\045\000\015\000\
\024\000\046\000\007\000\008\000\009\000\015\000\017\000\017\000\
\013\000\017\000\017\000\036\000\037\000\038\000\039\000\017\000\
\069\000\013\000\071\000\057\000\025\000\058\000\029\000\030\000\
\017\000\001\000\002\000\003\000\004\000\005\000\007\000\008\000\
\009\000\032\000\008\000\009\000\026\000\027\000\028\000\031\000\
\042\000\047\000\050\000\051\000\044\000\048\000\061\000\052\000\
\053\000\054\000\065\000\055\000\056\000\059\000\063\000\009\000\
\061\000\066\000\061\000\031\000\024\000\068\000\049\000\064\000\
\067\000\070\000\018\000\000\000\000\000\000\000\072\000\022\000\
\000\000\023\000"

let yycheck = "\001\000\
\024\000\003\000\007\001\001\001\005\001\006\001\027\000\008\001\
\001\001\030\000\015\001\016\001\017\001\014\001\005\001\006\001\
\005\001\008\001\020\000\015\001\016\001\017\001\018\001\014\001\
\066\000\014\001\068\000\051\000\014\001\053\000\005\001\006\001\
\034\000\001\000\002\000\003\000\004\000\005\000\015\001\016\001\
\017\001\015\001\016\001\017\001\009\001\008\001\014\001\014\001\
\014\001\011\001\002\001\008\001\016\001\014\001\056\000\002\001\
\001\001\005\001\060\000\012\001\006\001\011\001\002\001\014\001\
\066\000\008\001\068\000\009\001\002\001\008\001\034\000\015\001\
\013\001\011\001\003\000\255\255\255\255\255\255\015\001\014\001\
\255\255\014\001"

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
# 175 "clparser.ml"
               : Clast.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 59 "clparser.mly"
                ( _1 )
# 182 "clparser.ml"
               : Clast.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 62 "clparser.mly"
                 ( _1 )
# 189 "clparser.ml"
               : Clast.literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 65 "clparser.mly"
               ( _1 )
# 196 "clparser.ml"
               : Clast.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 68 "clparser.mly"
              ( _1 )
# 203 "clparser.ml"
               : Clast.query))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "clparser.mly"
                   ( [] )
# 209 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'abbrev) in
    Obj.repr(
# 72 "clparser.mly"
                   ( _2 :: _1 )
# 217 "clparser.ml"
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
# 230 "clparser.ml"
               : 'abbrev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 83 "clparser.mly"
           ( [_1] )
# 237 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 84 "clparser.mly"
                   ( _1 :: _2 )
# 245 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 87 "clparser.mly"
                ( Clast.Clause (_1, []) )
# 252 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 88 "clparser.mly"
                            ( Clast.Clause (_1, _3) )
# 260 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 91 "clparser.mly"
            ( [_1] )
# 267 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literals) in
    Obj.repr(
# 92 "clparser.mly"
                           ( _1 :: _3 )
# 275 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 95 "clparser.mly"
               ( Clast.Atom (_1, []) )
# 282 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 97 "clparser.mly"
    ( Clast.Atom (_1, _3) )
# 290 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 99 "clparser.mly"
    ( Clast.Attestation (current_location (), _1, _3, []) )
# 298 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 101 "clparser.mly"
    ( Clast.Attestation (current_location (), _1, _3, _5) )
# 307 "clparser.ml"
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
# 318 "clparser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 112 "clparser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 326 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 114 "clparser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 334 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 115 "clparser.mly"
            ( [_1], [] )
# 341 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 116 "clparser.mly"
                ( [], [_2] )
# 348 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 119 "clparser.mly"
         ( [_1] )
# 355 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 120 "clparser.mly"
                     ( _1 :: _3 )
# 363 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 123 "clparser.mly"
        ( Clast.Const _1 )
# 370 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 124 "clparser.mly"
               ( Clast.Const _1 )
# 377 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 125 "clparser.mly"
               ( Clast.Var _1 )
# 384 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 126 "clparser.mly"
                  ( Clast.Quoted _1 )
# 391 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 129 "clparser.mly"
               ( Clast.PrincipalVar _1 )
# 398 "clparser.ml"
               : 'principal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 130 "clparser.mly"
                  ( Clast.PrincipalName (without_quotes _1) )
# 405 "clparser.ml"
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
