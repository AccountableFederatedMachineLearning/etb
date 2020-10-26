type token =
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS
  | DOT
  | IF
  | NOT
  | COMMA
  | EOI
  | SINGLE_QUOTED of (string)
  | LOWER_WORD of (string)
  | UPPER_WORD of (string)
  | INT of (string)

open Parsing;;
let _ = parse_error;;
# 6 "Parser.mly"
# 18 "Parser.ml"
let yytransl_const = [|
  257 (* LEFT_PARENTHESIS *);
  258 (* RIGHT_PARENTHESIS *);
  259 (* DOT *);
  260 (* IF *);
  261 (* NOT *);
  262 (* COMMA *);
  263 (* EOI *);
    0|]

let yytransl_block = [|
  264 (* SINGLE_QUOTED *);
  265 (* LOWER_WORD *);
  266 (* UPPER_WORD *);
  267 (* INT *);
    0|]

let yylhs = "\255\255\
\004\000\001\000\002\000\003\000\005\000\006\000\006\000\009\000\
\009\000\008\000\008\000\007\000\007\000\010\000\012\000\012\000\
\012\000\012\000\011\000\011\000\013\000\013\000\013\000\013\000\
\000\000\000\000\000\000\000\000\000\000"

let yylen = "\002\000\
\002\000\002\000\002\000\002\000\002\000\001\000\002\000\002\000\
\004\000\001\000\003\000\001\000\004\000\005\000\003\000\004\000\
\001\000\002\000\001\000\003\000\001\000\001\000\001\000\001\000\
\002\000\002\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\025\000\
\000\000\026\000\000\000\000\000\027\000\000\000\000\000\028\000\
\000\000\000\000\000\000\029\000\000\000\000\000\002\000\000\000\
\003\000\008\000\000\000\004\000\001\000\007\000\024\000\022\000\
\023\000\021\000\000\000\000\000\005\000\000\000\011\000\000\000\
\000\000\000\000\013\000\009\000\000\000\020\000\000\000\000\000\
\014\000\000\000\000\000\000\000\015\000\016\000"

let yydgoto = "\006\000\
\008\000\010\000\013\000\016\000\020\000\017\000\011\000\012\000\
\018\000\021\000\035\000\049\000\036\000"

let yysindex = "\003\000\
\011\255\011\255\011\255\011\255\029\255\000\000\030\255\000\000\
\025\255\000\000\027\255\028\255\000\000\023\255\031\255\000\000\
\032\255\011\255\014\255\000\000\033\255\014\255\000\000\011\255\
\000\000\000\000\011\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\034\255\035\255\000\000\040\255\000\000\042\255\
\039\255\014\255\000\000\000\000\009\255\000\000\011\255\041\255\
\000\000\043\255\009\255\009\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\006\255\000\000\
\000\000\000\000\008\255\000\000\000\000\000\000\000\000\000\000\
\000\000\045\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\046\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\047\255\
\000\000\048\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\016\000\255\255\248\255\
\034\000\000\000\235\255\233\255\000\000"

let yytablesize = 55
let yytable = "\009\000\
\038\000\014\000\014\000\001\000\002\000\003\000\004\000\005\000\
\012\000\012\000\010\000\012\000\012\000\047\000\010\000\039\000\
\014\000\007\000\040\000\007\000\046\000\031\000\032\000\033\000\
\034\000\026\000\027\000\053\000\054\000\019\000\022\000\023\000\
\024\000\030\000\025\000\041\000\015\000\028\000\029\000\037\000\
\042\000\043\000\045\000\048\000\044\000\050\000\051\000\019\000\
\052\000\048\000\048\000\006\000\000\000\017\000\018\000"

let yycheck = "\001\000\
\022\000\003\000\004\000\001\000\002\000\003\000\004\000\005\000\
\003\001\004\001\003\001\006\001\007\001\005\001\007\001\024\000\
\018\000\009\001\027\000\009\001\042\000\008\001\009\001\010\001\
\011\001\003\001\004\001\051\000\052\000\001\001\001\001\007\001\
\006\001\018\000\007\001\002\001\003\000\007\001\007\001\007\001\
\006\001\002\001\004\001\045\000\003\001\047\000\006\001\002\001\
\006\001\051\000\052\000\007\001\255\255\007\001\007\001"

let yynames_const = "\
  LEFT_PARENTHESIS\000\
  RIGHT_PARENTHESIS\000\
  DOT\000\
  IF\000\
  NOT\000\
  COMMA\000\
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
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clauses) in
    Obj.repr(
# 38 "Parser.mly"
                ( _1 )
# 126 "Parser.ml"
               : AST.file))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 41 "Parser.mly"
                ( _1 )
# 133 "Parser.ml"
               : AST.literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 44 "Parser.mly"
                 ( _1 )
# 140 "Parser.ml"
               : AST.literal list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    Obj.repr(
# 47 "Parser.mly"
               ( _1 )
# 147 "Parser.ml"
               : AST.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'query) in
    Obj.repr(
# 50 "Parser.mly"
              ( _1 )
# 154 "Parser.ml"
               : AST.query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 53 "Parser.mly"
           ( [_1] )
# 161 "Parser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 54 "Parser.mly"
                   ( _1 :: _2 )
# 169 "Parser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'literal) in
    Obj.repr(
# 57 "Parser.mly"
                ( AST.Clause (_1, []) )
# 176 "Parser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'literals) in
    Obj.repr(
# 58 "Parser.mly"
                            ( AST.Clause (_1, _3) )
# 184 "Parser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 61 "Parser.mly"
            ( [_1] )
# 191 "Parser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'literals) in
    Obj.repr(
# 62 "Parser.mly"
                           ( _1 :: _3 )
# 199 "Parser.ml"
               : 'literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "Parser.mly"
               ( AST.Atom (_1, []) )
# 206 "Parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    Obj.repr(
# 67 "Parser.mly"
    ( AST.Atom (_1, _3) )
# 214 "Parser.ml"
               : 'literal))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'args) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 71 "Parser.mly"
    (
      let pos_literals, neg_literal = _5 in
      AST.Query (_2, pos_literals, neg_literal)
    )
# 225 "Parser.ml"
               : 'query))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 78 "Parser.mly"
    ( let pos, neg = _3 in _1 :: pos, neg )
# 233 "Parser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'literal) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'signed_literals) in
    Obj.repr(
# 80 "Parser.mly"
    ( let pos, neg = _4 in pos, _2 :: neg )
# 241 "Parser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 81 "Parser.mly"
            ( [_1], [] )
# 248 "Parser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'literal) in
    Obj.repr(
# 82 "Parser.mly"
                ( [], [_2] )
# 255 "Parser.ml"
               : 'signed_literals))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 85 "Parser.mly"
         ( [_1] )
# 262 "Parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 86 "Parser.mly"
                     ( _1 :: _3 )
# 270 "Parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 89 "Parser.mly"
        ( AST.Const _1 )
# 277 "Parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 90 "Parser.mly"
               ( AST.Const _1 )
# 284 "Parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 91 "Parser.mly"
               ( AST.Var _1 )
# 291 "Parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 92 "Parser.mly"
                  ( AST.Quoted _1 )
# 298 "Parser.ml"
               : 'term))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : AST.literal)
let parse_literals (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : AST.literal list)
let parse_clause (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 3 lexfun lexbuf : AST.clause)
let parse_file (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 4 lexfun lexbuf : AST.file)
let parse_query (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 5 lexfun lexbuf : AST.query)
