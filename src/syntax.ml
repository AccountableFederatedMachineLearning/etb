open Default

exception Error of {
    line : int;
    column : int
  }

module Datalog = struct

  let parse_with_exn rule token lexbuf =
    try
      rule token lexbuf
    with _ ->
      let curr = lexbuf.Lexing.lex_curr_p in
      let line = curr.Lexing.pos_lnum in
      let col = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
      raise (Error { line = line; column = col })

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

  let short_literal literal =
    let open Cyberlogic in
    let color = match color literal with 
      | Yellow -> "yellow"
      | Green -> "green"
      | ColorVar i when i >= 0 -> "X" ^ (string_of_int i)
      | ColorVar i -> "Y" ^ (string_of_int (-i)) in
    let principal = match Id.Name.get (principal literal).subject "CN" with
      | None -> "<unknown>"
      | Some n -> n in
    let claim = Datalog.string_of_literal (plain_literal literal) in
    principal ^ " says " ^ claim ^ " [" ^ color ^ "]"

  let short_clause clause =
    let h = short_literal (Cyberlogic.head clause) in
    let bs = List.map short_literal (Cyberlogic.body clause) in
    match bs with 
    | [] -> h
    | (b :: rest) -> List.fold_left (fun s l -> s ^ ", " ^ l) 
                       (h ^ " :- " ^ b) rest

end