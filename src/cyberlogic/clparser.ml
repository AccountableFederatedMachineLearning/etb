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

# 42 "clparser.ml"
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
  266 (* LT *);
  267 (* LE *);
  268 (* GT *);
  269 (* GE *);
  270 (* EQ *);
  271 (* NE *);
  272 (* EQUALS *);
  273 (* COLON *);
  274 (* SUBJECT *);
  275 (* ISSUER *);
  276 (* EOI *);
    0|]

let yytransl_block = [|
  277 (* SINGLE_QUOTED *);
  278 (* LOWER_WORD *);
  279 (* UPPER_WORD *);
  280 (* INT *);
    0|]

let yylhs = "\255\255\
\004\000\001\000\002\000\003\000\005\000\006\000\006\000\012\000\
\007\000\007\000\010\000\010\000\009\000\009\000\013\000\013\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
\011\000\017\000\017\000\017\000\017\000\015\000\015\000\016\000\
\016\000\016\000\016\000\014\000\014\000\000\000\000\000\000\000\
\000\000\000\000"

let yylen = "\002\000\
\003\000\002\000\002\000\002\000\002\000\000\000\002\000\008\000\
\001\000\002\000\002\000\004\000\001\000\003\000\001\000\003\000\
\001\000\004\000\003\000\003\000\003\000\003\000\003\000\003\000\
\005\000\003\000\004\000\001\000\002\000\001\000\003\000\001\000\
\001\000\001\000\001\000\001\000\001\000\002\000\002\000\002\000\
\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\006\000\000\000\000\000\035\000\000\000\
\034\000\032\000\038\000\000\000\000\000\000\000\000\000\039\000\
\015\000\000\000\000\000\000\000\040\000\000\000\000\000\041\000\
\000\000\000\000\042\000\000\000\000\000\002\000\000\000\000\000\
\000\000\000\000\000\000\000\000\003\000\000\000\000\000\011\000\
\000\000\004\000\000\000\000\000\000\000\007\000\033\000\000\000\
\000\000\005\000\000\000\019\000\020\000\021\000\022\000\023\000\
\024\000\014\000\016\000\000\000\000\000\001\000\010\000\000\000\
\000\000\018\000\012\000\000\000\000\000\031\000\000\000\000\000\
\000\000\025\000\000\000\000\000\000\000\000\000\000\000\026\000\
\000\000\027\000\008\000"

let yydgoto = "\006\000\
\011\000\016\000\021\000\024\000\027\000\025\000\044\000\017\000\
\018\000\045\000\028\000\046\000\019\000\020\000\048\000\013\000\
\074\000"

let yysindex = "\013\000\
\051\255\064\255\051\255\000\000\011\255\000\000\000\000\029\255\
\000\000\000\000\000\000\017\255\049\255\000\000\000\000\000\000\
\000\000\045\255\059\255\061\255\000\000\037\255\057\255\000\000\
\068\255\072\255\000\000\077\255\072\255\000\000\072\255\072\255\
\072\255\072\255\072\255\072\255\000\000\064\255\051\255\000\000\
\064\255\000\000\081\255\079\255\051\255\000\000\000\000\098\255\
\093\255\000\000\100\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\099\255\085\255\000\000\000\000\101\255\
\072\255\000\000\000\000\088\255\254\254\000\000\087\255\051\255\
\102\255\000\000\090\255\103\255\254\254\089\255\254\254\000\000\
\091\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\021\255\
\000\000\000\000\000\000\000\000\000\000\036\255\043\255\000\000\
\000\000\000\000\008\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\069\255\000\000\094\255\000\000\000\000\000\000\
\111\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\095\255\000\000\000\000\096\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\072\000\255\255\
\028\000\115\000\000\000\000\000\000\000\000\000\230\255\231\255\
\202\255"

let yytablesize = 118
let yytable = "\012\000\
\049\000\022\000\051\000\049\000\072\000\052\000\053\000\054\000\
\055\000\056\000\057\000\026\000\013\000\001\000\002\000\003\000\
\004\000\005\000\007\000\008\000\009\000\010\000\080\000\022\000\
\082\000\017\000\017\000\013\000\017\000\029\000\033\000\033\000\
\033\000\033\000\033\000\033\000\030\000\059\000\070\000\049\000\
\017\000\040\000\041\000\022\000\037\000\035\000\035\000\035\000\
\035\000\035\000\035\000\036\000\034\000\034\000\034\000\034\000\
\034\000\034\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\058\000\038\000\073\000\060\000\039\000\076\000\007\000\
\008\000\009\000\010\000\073\000\042\000\073\000\035\000\035\000\
\035\000\035\000\035\000\035\000\014\000\008\000\015\000\010\000\
\043\000\008\000\009\000\010\000\007\000\047\000\009\000\010\000\
\050\000\061\000\062\000\064\000\065\000\066\000\068\000\067\000\
\071\000\081\000\069\000\075\000\078\000\077\000\079\000\083\000\
\030\000\009\000\028\000\029\000\063\000\023\000"

let yycheck = "\001\000\
\026\000\003\000\029\000\029\000\007\001\031\000\032\000\033\000\
\034\000\035\000\036\000\001\001\005\001\001\000\002\000\003\000\
\004\000\005\000\021\001\022\001\023\001\024\001\077\000\025\000\
\079\000\005\001\006\001\020\001\008\001\001\001\010\001\011\001\
\012\001\013\001\014\001\015\001\020\001\039\000\065\000\065\000\
\020\001\005\001\006\001\045\000\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\010\001\011\001\012\001\013\001\014\001\015\001\
\020\001\038\000\008\001\069\000\041\000\009\001\072\000\021\001\
\022\001\023\001\024\001\077\000\020\001\079\000\010\001\011\001\
\012\001\013\001\014\001\015\001\021\001\022\001\023\001\024\001\
\021\001\022\001\023\001\024\001\021\001\022\001\023\001\024\001\
\020\001\017\001\020\001\002\001\008\001\002\001\018\001\005\001\
\017\001\017\001\006\001\021\001\019\001\008\001\008\001\021\001\
\002\001\020\001\020\001\020\001\045\000\003\000"

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
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'clauses) in
    Obj.repr(
# 57 "clparser.mly"
                        ( (_1, _2) )
# 211 "clparser.ml"
               : Clast.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 60 "clparser.mly"
                ( _1 )
# 218 "clparser.ml"
               : Clast.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'attested_literals) in
    Obj.repr(
# 63 "clparser.mly"
                          ( _1 )
# 225 "clparser.ml"
               : Clast.attested_literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 66 "clparser.mly"
               ( _1 )
# 232 "clparser.ml"
               : Clast.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 69 "clparser.mly"
              ( _1 )
# 239 "clparser.ml"
               : Clast.query))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "clparser.mly"
                   ( [] )
# 245 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'abbrev) in
    Obj.repr(
# 73 "clparser.mly"
                   ( _2 :: _1 )
# 253 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 77 "clparser.mly"
     ( (without_quotes _1, 
        Id.{ subject = DN.make_exn (without_quotes _5);
             issuer = DN.make_exn (without_quotes _8)
        })
     )
# 266 "clparser.ml"
               : 'abbrev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 84 "clparser.mly"
           ( [_1] )
# 273 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 85 "clparser.mly"
                   ( _1 :: _2 )
# 281 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 88 "clparser.mly"
                ( Clast.Clause (_1, []) )
# 288 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'attested_literals) in
    Obj.repr(
# 89 "clparser.mly"
                                     ( Clast.Clause (_1, _3) )
# 296 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'attested_literal) in
    Obj.repr(
# 92 "clparser.mly"
                     ( [_1] )
# 303 "clparser.ml"
               : 'attested_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'attested_literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'attested_literals) in
    Obj.repr(
# 93 "clparser.mly"
                                             ( _1 :: _3 )
# 311 "clparser.ml"
               : 'attested_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 96 "clparser.mly"
            ( Clast.Unattested _1 )
# 318 "clparser.ml"
               : 'attested_literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 98 "clparser.mly"
     ( Clast.Attested (current_location (), _1, _3) )
# 326 "clparser.ml"
               : 'attested_literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 101 "clparser.mly"
               ( Clast.Atom (_1, []) )
# 333 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 103 "clparser.mly"
    ( Clast.Atom (_1, _3) )
# 341 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 104 "clparser.mly"
                   ( Clast.Atom ("lt", [_1; _3]) )
# 349 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 105 "clparser.mly"
                   ( Clast.Atom ("le", [_1; _3]) )
# 357 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 106 "clparser.mly"
                   ( Clast.Atom ("gt", [_1; _3]) )
# 365 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 107 "clparser.mly"
                   ( Clast.Atom ("ge", [_1; _3]) )
# 373 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 108 "clparser.mly"
                   ( Clast.Atom ("eq", [_1; _3]) )
# 381 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 109 "clparser.mly"
                   ( Clast.Atom ("ne", [_1; _3]) )
# 389 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'args) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 113 "clparser.mly"
    (
      let pos_literals, neg_literal = _5 in
      Clast.Query (_2, pos_literals, neg_literal)
    )
# 400 "clparser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 120 "clparser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 408 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 122 "clparser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 416 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 123 "clparser.mly"
            ( [_1], [] )
# 423 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 124 "clparser.mly"
                ( [], [_2] )
# 430 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 127 "clparser.mly"
         ( [_1] )
# 437 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 128 "clparser.mly"
                     ( _1 :: _3 )
# 445 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 131 "clparser.mly"
        ( Clast.Const _1 )
# 452 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 132 "clparser.mly"
               ( Clast.Const _1 )
# 459 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 133 "clparser.mly"
               ( Clast.Var _1 )
# 466 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 134 "clparser.mly"
                  ( Clast.Quoted _1 )
# 473 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 137 "clparser.mly"
               ( Clast.PrincipalVar _1 )
# 480 "clparser.ml"
               : 'principal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 138 "clparser.mly"
                  ( Clast.PrincipalName (without_quotes _1) )
# 487 "clparser.ml"
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
