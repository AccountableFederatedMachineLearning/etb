type token =
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS
  | LEFT_BRACKET
  | RIGHT_BRACKET
  | DOT
  | IF
  | NOT
  | COMMA
  | ATTESTS
  | GOAL
  | LT
  | LE
  | GT
  | GE
  | EQ
  | NE
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

# 43 "clparser.ml"
let yytransl_const = [|
  257 (* LEFT_PARENTHESIS *);
  258 (* RIGHT_PARENTHESIS *);
  259 (* LEFT_BRACKET *);
  260 (* RIGHT_BRACKET *);
  261 (* DOT *);
  262 (* IF *);
  263 (* NOT *);
  264 (* COMMA *);
  265 (* ATTESTS *);
  266 (* GOAL *);
  267 (* LT *);
  268 (* LE *);
  269 (* GT *);
  270 (* GE *);
  271 (* EQ *);
  272 (* NE *);
  273 (* EQUALS *);
  274 (* COLON *);
  275 (* SUBJECT *);
  276 (* ISSUER *);
  277 (* EOI *);
    0|]

let yytransl_block = [|
  278 (* SINGLE_QUOTED *);
  279 (* LOWER_WORD *);
  280 (* UPPER_WORD *);
  281 (* INT *);
    0|]

let yylhs = "\255\255\
\004\000\001\000\002\000\003\000\005\000\006\000\006\000\013\000\
\007\000\007\000\011\000\011\000\008\000\008\000\014\000\010\000\
\010\000\015\000\015\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\012\000\019\000\019\000\019\000\019\000\
\017\000\017\000\018\000\018\000\018\000\018\000\016\000\016\000\
\000\000\000\000\000\000\000\000\000\000"

let yylen = "\002\000\
\004\000\002\000\002\000\002\000\002\000\000\000\002\000\008\000\
\000\000\002\000\002\000\004\000\000\000\002\000\003\000\001\000\
\003\000\001\000\003\000\001\000\004\000\003\000\003\000\003\000\
\003\000\003\000\003\000\005\000\003\000\004\000\001\000\002\000\
\001\000\003\000\001\000\001\000\001\000\001\000\001\000\001\000\
\002\000\002\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\006\000\000\000\000\000\038\000\000\000\
\037\000\035\000\041\000\000\000\000\000\000\000\000\000\042\000\
\018\000\000\000\000\000\000\000\043\000\000\000\000\000\044\000\
\000\000\000\000\045\000\000\000\000\000\002\000\000\000\000\000\
\000\000\000\000\000\000\000\000\003\000\000\000\000\000\011\000\
\000\000\004\000\000\000\000\000\000\000\007\000\036\000\000\000\
\000\000\005\000\000\000\022\000\023\000\024\000\025\000\026\000\
\027\000\017\000\019\000\000\000\000\000\000\000\000\000\000\000\
\010\000\000\000\000\000\021\000\012\000\000\000\000\000\001\000\
\014\000\000\000\034\000\000\000\015\000\000\000\000\000\028\000\
\000\000\000\000\000\000\000\000\000\000\029\000\000\000\030\000\
\008\000"

let yydgoto = "\006\000\
\011\000\016\000\021\000\024\000\027\000\025\000\044\000\063\000\
\017\000\018\000\045\000\028\000\046\000\064\000\019\000\020\000\
\048\000\013\000\080\000"

let yysindex = "\014\000\
\056\255\075\255\056\255\000\000\012\255\000\000\000\000\025\255\
\000\000\000\000\000\000\019\255\074\255\000\000\000\000\000\000\
\000\000\022\255\037\255\039\255\000\000\045\255\038\255\000\000\
\079\255\083\255\000\000\043\255\083\255\000\000\083\255\083\255\
\083\255\083\255\083\255\083\255\000\000\075\255\056\255\000\000\
\075\255\000\000\040\255\050\255\056\255\000\000\000\000\069\255\
\064\255\000\000\072\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\070\255\057\255\056\255\062\255\050\255\
\000\000\103\255\083\255\000\000\000\000\092\255\106\255\000\000\
\000\000\254\254\000\000\090\255\000\000\056\255\105\255\000\000\
\094\255\107\255\254\254\098\255\254\254\000\000\095\255\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\041\255\
\000\000\000\000\000\000\000\000\000\000\018\255\054\255\000\000\
\000\000\000\000\007\255\000\000\000\000\000\000\000\000\000\000\
\004\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\080\255\097\255\004\255\000\000\000\000\000\000\
\117\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\097\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\099\255\000\000\
\000\000\100\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\077\000\059\000\
\255\255\254\255\121\000\000\000\000\000\000\000\000\000\000\000\
\230\255\231\255\208\255"

let yytablesize = 124
let yytable = "\012\000\
\049\000\022\000\051\000\049\000\078\000\052\000\053\000\054\000\
\055\000\056\000\057\000\016\000\026\000\009\000\001\000\002\000\
\003\000\004\000\005\000\007\000\008\000\009\000\010\000\022\000\
\009\000\029\000\040\000\016\000\038\000\038\000\038\000\038\000\
\038\000\038\000\086\000\058\000\088\000\059\000\060\000\030\000\
\075\000\049\000\037\000\022\000\038\000\020\000\020\000\039\000\
\020\000\040\000\041\000\036\000\036\000\036\000\036\000\036\000\
\036\000\061\000\042\000\062\000\071\000\020\000\039\000\050\000\
\037\000\037\000\037\000\037\000\037\000\037\000\066\000\067\000\
\079\000\068\000\069\000\070\000\082\000\007\000\008\000\009\000\
\010\000\079\000\072\000\079\000\031\000\032\000\033\000\034\000\
\035\000\036\000\038\000\038\000\038\000\038\000\038\000\038\000\
\014\000\008\000\015\000\010\000\043\000\008\000\009\000\010\000\
\007\000\047\000\009\000\010\000\074\000\076\000\077\000\081\000\
\083\000\084\000\085\000\087\000\089\000\013\000\033\000\031\000\
\032\000\065\000\073\000\023\000"

let yycheck = "\001\000\
\026\000\003\000\029\000\029\000\007\001\031\000\032\000\033\000\
\034\000\035\000\036\000\005\001\001\001\010\001\001\000\002\000\
\003\000\004\000\005\000\022\001\023\001\024\001\025\001\025\000\
\021\001\001\001\009\001\021\001\011\001\012\001\013\001\014\001\
\015\001\016\001\083\000\038\000\085\000\039\000\041\000\021\001\
\067\000\067\000\021\001\045\000\008\001\005\001\006\001\009\001\
\008\001\005\001\006\001\011\001\012\001\013\001\014\001\015\001\
\016\001\018\001\021\001\010\001\062\000\021\001\009\001\021\001\
\011\001\012\001\013\001\014\001\015\001\016\001\002\001\008\001\
\074\000\002\001\005\001\019\001\078\000\022\001\023\001\024\001\
\025\001\083\000\021\001\085\000\011\001\012\001\013\001\014\001\
\015\001\016\001\011\001\012\001\013\001\014\001\015\001\016\001\
\022\001\023\001\024\001\025\001\022\001\023\001\024\001\025\001\
\022\001\023\001\024\001\025\001\006\001\018\001\005\001\022\001\
\008\001\020\001\008\001\018\001\022\001\021\001\002\001\021\001\
\021\001\045\000\064\000\003\000"

let yynames_const = "\
  LEFT_PARENTHESIS\000\
  RIGHT_PARENTHESIS\000\
  LEFT_BRACKET\000\
  RIGHT_BRACKET\000\
  DOT\000\
  IF\000\
  NOT\000\
  COMMA\000\
  ATTESTS\000\
  GOAL\000\
  LT\000\
  LE\000\
  GT\000\
  GE\000\
  EQ\000\
  NE\000\
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
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'clauses) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'goals) in
    Obj.repr(
# 58 "clparser.mly"
    ( { identities = _1; clauses = _2; goals = _3 }  )
# 220 "clparser.ml"
               : Clast.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 61 "clparser.mly"
                ( _1 )
# 227 "clparser.ml"
               : Clast.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'attested_literals) in
    Obj.repr(
# 64 "clparser.mly"
                          ( _1 )
# 234 "clparser.ml"
               : Clast.attested_literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 67 "clparser.mly"
               ( _1 )
# 241 "clparser.ml"
               : Clast.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 70 "clparser.mly"
              ( _1 )
# 248 "clparser.ml"
               : Clast.query))
; (fun __caml_parser_env ->
    Obj.repr(
# 73 "clparser.mly"
                   ( [] )
# 254 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'abbrev) in
    Obj.repr(
# 74 "clparser.mly"
                   ( _2 :: _1 )
# 262 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 78 "clparser.mly"
     ( (without_quotes _1, 
        Id.{ subject = DN.make_exn (without_quotes _5);
             issuer = DN.make_exn (without_quotes _8)
        })
     )
# 275 "clparser.ml"
               : 'abbrev))
; (fun __caml_parser_env ->
    Obj.repr(
# 85 "clparser.mly"
       ( [] )
# 281 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 86 "clparser.mly"
                   ( _1 :: _2 )
# 289 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 89 "clparser.mly"
                ( Clast.Clause (_1, []) )
# 296 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'attested_literals) in
    Obj.repr(
# 90 "clparser.mly"
                                     ( Clast.Clause (_1, _3) )
# 304 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    Obj.repr(
# 93 "clparser.mly"
      ( [] )
# 310 "clparser.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'goal) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'goals) in
    Obj.repr(
# 94 "clparser.mly"
               ( _1 :: _2 )
# 318 "clparser.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 97 "clparser.mly"
                     ( _2 )
# 325 "clparser.ml"
               : 'goal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'attested_literal) in
    Obj.repr(
# 100 "clparser.mly"
                     ( [_1] )
# 332 "clparser.ml"
               : 'attested_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'attested_literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'attested_literals) in
    Obj.repr(
# 101 "clparser.mly"
                                             ( _1 :: _3 )
# 340 "clparser.ml"
               : 'attested_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 104 "clparser.mly"
            ( Clast.Unattested _1 )
# 347 "clparser.ml"
               : 'attested_literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 106 "clparser.mly"
     ( Clast.Attested (current_location (), _1, _3) )
# 355 "clparser.ml"
               : 'attested_literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 109 "clparser.mly"
               ( Clast.Atom (_1, []) )
# 362 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 111 "clparser.mly"
    ( Clast.Atom (_1, _3) )
# 370 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 112 "clparser.mly"
                   ( Clast.Atom ("lt", [_1; _3]) )
# 378 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 113 "clparser.mly"
                   ( Clast.Atom ("le", [_1; _3]) )
# 386 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 114 "clparser.mly"
                   ( Clast.Atom ("gt", [_1; _3]) )
# 394 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 115 "clparser.mly"
                   ( Clast.Atom ("ge", [_1; _3]) )
# 402 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 116 "clparser.mly"
                   ( Clast.Atom ("eq", [_1; _3]) )
# 410 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 117 "clparser.mly"
                   ( Clast.Atom ("ne", [_1; _3]) )
# 418 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'args) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 121 "clparser.mly"
    (
      let pos_literals, neg_literal = _5 in
      Clast.Query (_2, pos_literals, neg_literal)
    )
# 429 "clparser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 128 "clparser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 437 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 130 "clparser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 445 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 131 "clparser.mly"
            ( [_1], [] )
# 452 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 132 "clparser.mly"
                ( [], [_2] )
# 459 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 135 "clparser.mly"
         ( [_1] )
# 466 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 136 "clparser.mly"
                     ( _1 :: _3 )
# 474 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 139 "clparser.mly"
        ( Clast.Const _1 )
# 481 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 140 "clparser.mly"
               ( Clast.Const _1 )
# 488 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 141 "clparser.mly"
               ( Clast.Var _1 )
# 495 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 142 "clparser.mly"
                  ( Clast.Quoted _1 )
# 502 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 145 "clparser.mly"
               ( Clast.PrincipalVar _1 )
# 509 "clparser.ml"
               : 'principal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 146 "clparser.mly"
                  ( Clast.PrincipalName (without_quotes _1) )
# 516 "clparser.ml"
               : 'principal))
(* Entry parse_literal *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry parse_attested_literals *)
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
let parse_attested_literals (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : Clast.attested_literal list)
let parse_clause (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 3 lexfun lexbuf : Clast.clause)
let parse_file (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 4 lexfun lexbuf : Clast.file)
let parse_query (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 5 lexfun lexbuf : Clast.query)
