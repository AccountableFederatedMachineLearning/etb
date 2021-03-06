
exception Error of {
    line : int;
    column : int;
    msg : string
  }

let parse_with_exn rule token lexbuf =
  try
    rule token lexbuf
  with _ ->
    let curr = lexbuf.Lexing.lex_curr_p in
    let line = curr.Lexing.pos_lnum in
    let col = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
    raise (Error { line = line; column = col; msg = "Parse Error" })

module Datalog = struct
  open Default

  let parse_literal_exn s =
    let lex = Lexing.from_string s in
    let ac = parse_with_exn Parser.parse_literal Lexer.token lex in
    Default.literal_of_ast(ac)

  let parse_clause_exn s =
    let lex = Lexing.from_string s in
    let ac = parse_with_exn Parser.parse_clause Lexer.token lex in
    Default.clause_of_ast(ac)

  let parse_file_exn s =
    let lex = Lexing.from_string s in
    let ac = parse_with_exn Parser.parse_file Lexer.token lex in
    List.map Default.clause_of_ast ac


  let pp_to_string pp x : string =
    pp Format.str_formatter x;
    Format.flush_str_formatter ()

  let string_of_literal l = 
    pp_to_string pp_literal l

  let string_of_clause l = 
    pp_to_string pp_clause l

end

module Cyberlogic = struct

  (* Parsing *)

  (* The following parsing code is adapted from datalog/default.ml
     Please refer to datalog/LICENSE for license information *)

  module A = Clast

  open Cyberlogic

  type vartbl = {
    mutable vartbl_count : int;
    vartbl_tbl : (string,int) Hashtbl.t;
  }

  let mk_vartbl () =
    { vartbl_count = 0;
      vartbl_tbl = Hashtbl.create 5;
    }

  let nextvar ~tbl () =
    let n = tbl.vartbl_count in
    tbl.vartbl_count <- n + 1;
    n

  let getvar ~tbl name =
    try Hashtbl.find tbl.vartbl_tbl name
    with Not_found ->
      let n = tbl.vartbl_count in
      Hashtbl.add tbl.vartbl_tbl name n;
      tbl.vartbl_count <- n + 1;
      n

  let term_of_ast ~tbl ast = match ast with
    | A.Const s
    | A.Quoted s ->
      Default.mk_const (Default.StringSymbol.make s)
    | A.Var x ->
      Default.mk_var (getvar ~tbl x)

  let literal_of_ast id defs col ?(tbl=mk_vartbl ()) lit = match lit with
    | A.Unattested (A.Atom (s, args)) ->
      let s = Default.StringSymbol.make s in
      let args = List.map (term_of_ast ~tbl) args in
      Literal.make s col id args
    | A.Attested (loc, p, A.Atom (s, args)) ->
      let s = Default.StringSymbol.make s in
      let args = List.map (term_of_ast ~tbl) args in
      let principal  = 
        match p with
        | A.PrincipalVar i -> Principal.Var (getvar ~tbl i)
        | A.PrincipalName n ->
          match List.assoc_opt n defs with
          | None -> raise (
              Error { line = loc.A.line; 
                      column = loc.A.column; 
                      msg = "Identity '" ^ n ^ "' used but not defined" })
          | Some id -> Principal.Id id in
      Literal.make s col principal args

  let clause_of_ast id defs c = match c with
    | A.Clause (a, l) ->
      let tbl = mk_vartbl () in
      let a = literal_of_ast id defs Cyberlogic.Yellow ~tbl (A.Unattested a) in
      let l = List.map (fun x -> let col = Cyberlogic.ColorVar(nextvar ~tbl ()) in 
                         literal_of_ast id defs col ~tbl x) l in
      Clause.make a l

  let parse_literal_exn id col s = 
    let lex = Lexing.from_string s in
    let ac = parse_with_exn Clparser.parse_literal Cllexer.token lex in
    let defs = [] in
    literal_of_ast id defs col (A.Unattested ac)

  let parse_clause_exn id s =
    let lex = Lexing.from_string s in
    let ac = parse_with_exn Clparser.parse_clause Cllexer.token lex in
    let defs = [] in
    clause_of_ast id defs ac

  let parse_file_exn id s =
    let lex = Lexing.from_string s in
    let prg = parse_with_exn Clparser.parse_file Cllexer.token lex in
    let principal = Cyberlogic.Principal.Id id in
    { clauses =
        List.map (clause_of_ast principal prg.identities) prg.clauses;
      goals =
        List.map (fun l -> 
            literal_of_ast principal prg.identities Yellow (Unattested l)) 
          prg.goals
    }

  (* Printing *)

  let short_literal literal =
    let ansi_color = match Literal.color literal with 
      | Yellow -> "\027[0;33m"
      | Green _ -> "\027[0;32m"
      | ColorVar _ -> "" in
    let ansi_default_color = "\027[0;39m" in
    let color_string = match Literal.color literal with 
      | Yellow -> "yellow"
      | Green tid -> "green:" ^ tid
      | ColorVar i when i >= 0 -> "X" ^ (string_of_int i)
      | ColorVar i -> "Y" ^ (string_of_int (-i)) in
    let principal_string = 
      match Literal.principal literal with
      | Principal.Var i -> "<" ^ (string_of_int i) ^ ">"
      | Principal.Id id ->
        begin
          match Id.DN.get id.subject "CN" with
          | None -> "<unknown>"
          | Some n -> n 
        end
      | Principal.Undefined -> "<undefined>" in
    let claim_string = Datalog.string_of_literal (Literal.plain_literal literal) in
    ansi_color ^
    principal_string ^ " attests " ^ claim_string ^ " [" ^ color_string ^ "]" ^
    ansi_default_color

  let short_clause clause =
    let h = short_literal (Clause.head clause) in
    let bs = List.map short_literal (Clause.body clause) in
    match bs with 
    | [] -> h
    | (b :: rest) -> List.fold_left (fun s l -> s ^ ", " ^ l) 
                       (h ^ " :- " ^ b) rest

end