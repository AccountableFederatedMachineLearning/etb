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

open Parsing;;
let _ = parse_error;;
# 6 "clparser.mly"
  let without_quotes quoted =
    String.sub quoted 1 (String.length quoted - 2)
# 22 "clparser.ml"
let yytransl_const = [|
  257 (* LEFT_PARENTHESIS *);
  258 (* RIGHT_PARENTHESIS *);
  259 (* DOT *);
  260 (* IF *);
  261 (* NOT *);
  262 (* COMMA *);
  263 (* SAYS *);
  264 (* EQUALS *);
  265 (* EOI *);
    0|]

let yytransl_block = [|
  266 (* SINGLE_QUOTED *);
  267 (* LOWER_WORD *);
  268 (* UPPER_WORD *);
  269 (* INT *);
    0|]

let yylhs = "\255\255\
\004\000\001\000\002\000\003\000\005\000\006\000\006\000\012\000\
\007\000\007\000\010\000\010\000\009\000\009\000\008\000\008\000\
\008\000\008\000\011\000\015\000\015\000\015\000\015\000\014\000\
\014\000\016\000\016\000\016\000\016\000\013\000\000\000\000\000\
\000\000\000\000\000\000"

let yylen = "\002\000\
\003\000\002\000\002\000\002\000\002\000\000\000\002\000\003\000\
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
\000\000\000\000\016\000\000\000\012\000\008\000\000\000\025\000\
\000\000\000\000\000\000\019\000\018\000\000\000\000\000\000\000\
\020\000\021\000"

let yydgoto = "\006\000\
\009\000\012\000\015\000\018\000\021\000\019\000\032\000\013\000\
\014\000\033\000\022\000\034\000\011\000\039\000\060\000\040\000"

let yysindex = "\020\000\
\016\255\016\255\016\255\000\000\018\255\000\000\000\000\028\255\
\000\000\252\254\024\255\000\000\035\255\036\255\000\000\034\255\
\037\255\000\000\029\255\023\255\000\000\038\255\023\255\000\000\
\033\255\016\255\000\000\000\000\016\255\000\000\040\255\041\255\
\016\255\000\000\000\000\000\000\000\000\000\000\047\255\045\255\
\000\000\050\255\052\255\000\000\053\255\048\255\000\000\000\000\
\051\255\023\255\000\000\023\255\000\000\000\000\006\255\000\000\
\057\255\016\255\054\255\000\000\000\000\055\255\006\255\006\255\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\
\000\000\000\000\000\000\000\000\011\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\058\255\000\000\
\059\255\000\000\000\000\000\000\000\000\000\000\000\000\062\255\
\000\000\000\000\004\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\060\255\000\000\000\000\061\255\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\033\000\255\255\
\242\255\064\000\000\000\000\000\025\000\234\255\235\255\000\000"

let yytablesize = 71
let yytable = "\010\000\
\042\000\016\000\015\000\015\000\024\000\015\000\017\000\017\000\
\015\000\017\000\058\000\044\000\017\000\013\000\045\000\007\000\
\008\000\016\000\020\000\013\000\001\000\002\000\003\000\004\000\
\005\000\007\000\008\000\056\000\023\000\057\000\025\000\016\000\
\035\000\036\000\037\000\038\000\028\000\029\000\031\000\008\000\
\026\000\065\000\066\000\043\000\027\000\030\000\041\000\046\000\
\049\000\047\000\050\000\051\000\052\000\059\000\055\000\053\000\
\062\000\007\000\061\000\063\000\064\000\059\000\059\000\024\000\
\030\000\048\000\017\000\009\000\022\000\023\000\054\000"

let yycheck = "\001\000\
\023\000\003\000\003\001\004\001\009\001\006\001\003\001\004\001\
\009\001\006\001\005\001\026\000\009\001\003\001\029\000\010\001\
\011\001\019\000\001\001\009\001\001\000\002\000\003\000\004\000\
\005\000\010\001\011\001\050\000\001\001\052\000\007\001\033\000\
\010\001\011\001\012\001\013\001\003\001\004\001\010\001\011\001\
\006\001\063\000\064\000\011\001\009\001\009\001\009\001\008\001\
\002\001\009\001\006\001\002\001\001\001\055\000\004\001\003\001\
\058\000\010\001\002\001\006\001\006\001\063\000\064\000\002\001\
\007\001\033\000\003\000\009\001\009\001\009\001\046\000"

let yynames_const = "\
  LEFT_PARENTHESIS\000\
  RIGHT_PARENTHESIS\000\
  DOT\000\
  IF\000\
  NOT\000\
  COMMA\000\
  SAYS\000\
  EQUALS\000\
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
# 42 "clparser.mly"
                        ( (_1, _2) )
# 147 "clparser.ml"
               : Clast.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 45 "clparser.mly"
                ( _1 )
# 154 "clparser.ml"
               : Clast.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 48 "clparser.mly"
                 ( _1 )
# 161 "clparser.ml"
               : Clast.literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 51 "clparser.mly"
               ( _1 )
# 168 "clparser.ml"
               : Clast.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 54 "clparser.mly"
              ( _1 )
# 175 "clparser.ml"
               : Clast.query))
; (fun __caml_parser_env ->
    Obj.repr(
# 57 "clparser.mly"
                   ( [] )
# 181 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'abbrevs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'abbrev) in
    Obj.repr(
# 58 "clparser.mly"
                   ( _2 :: _1 )
# 189 "clparser.ml"
               : 'abbrevs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'principal) in
    Obj.repr(
# 61 "clparser.mly"
                                   ( (without_quotes _1, _3) )
# 197 "clparser.ml"
               : 'abbrev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 64 "clparser.mly"
           ( [_1] )
# 204 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 65 "clparser.mly"
                   ( _1 :: _2 )
# 212 "clparser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 68 "clparser.mly"
                ( Clast.Clause (_1, []) )
# 219 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 69 "clparser.mly"
                            ( Clast.Clause (_1, _3) )
# 227 "clparser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 72 "clparser.mly"
            ( [_1] )
# 234 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literals) in
    Obj.repr(
# 73 "clparser.mly"
                           ( _1 :: _3 )
# 242 "clparser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 76 "clparser.mly"
               ( Clast.Atom (_1, []) )
# 249 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 78 "clparser.mly"
    ( Clast.Atom (_1, _3) )
# 257 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 79 "clparser.mly"
                              ( Clast.Attestation (_1, _3, []) )
# 265 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'principal) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 81 "clparser.mly"
    ( Clast.Attestation (_1, _3, _5) )
# 274 "clparser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'args) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 85 "clparser.mly"
    (
      let pos_literals, neg_literal = _5 in
      Clast.Query (_2, pos_literals, neg_literal)
    )
# 285 "clparser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 92 "clparser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 293 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 94 "clparser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 301 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 95 "clparser.mly"
            ( [_1], [] )
# 308 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 96 "clparser.mly"
                ( [], [_2] )
# 315 "clparser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 99 "clparser.mly"
         ( [_1] )
# 322 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 100 "clparser.mly"
                     ( _1 :: _3 )
# 330 "clparser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 103 "clparser.mly"
        ( Clast.Const _1 )
# 337 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 104 "clparser.mly"
               ( Clast.Const _1 )
# 344 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 105 "clparser.mly"
               ( Clast.Var _1 )
# 351 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 106 "clparser.mly"
                  ( Clast.Quoted _1 )
# 358 "clparser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 109 "clparser.mly"
                  ( without_quotes _1 )
# 365 "clparser.ml"
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
