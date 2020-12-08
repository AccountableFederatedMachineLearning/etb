/*
this file is part of datalog. See README for the license
*/

%{
  let without_quotes quoted =
    String.sub quoted 1 (String.length quoted - 2)

  let location_of_pos pos =
    let open Lexing in
    { Clast.line = pos.pos_lnum;
      Clast.column = pos.pos_cnum - pos.pos_bol + 1 }

  let current_location () =
    location_of_pos (Parsing.symbol_start_pos ())

%}

%token LEFT_PARENTHESIS
%token RIGHT_PARENTHESIS
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token DOT
%token IF
%token NOT
%token COMMA
%token ATTESTS
%token LT LE GT GE EQ NE
%token EQUALS
%token COLON
%token SUBJECT
%token ISSUER
%token EOI
%token <string> SINGLE_QUOTED
%token <string> LOWER_WORD
%token <string> UPPER_WORD
%token <string> INT

%start parse_literal
%type <Clast.literal> parse_literal

%start parse_attested_literals
%type <Clast.attested_literal list> parse_attested_literals

%start parse_clause
%type <Clast.clause> parse_clause

%start parse_file
%type <Clast.file> parse_file

%start parse_query
%type <Clast.query> parse_query

%%

parse_file:
  | abbrevs clauses EOI { ($1, $2) }

parse_literal:
  | literal EOI { $1 }

parse_attested_literals:
  | attested_literals EOI { $1 }

parse_clause:
  | clause EOI { $1 }

parse_query:
  | query EOI { $1 }

abbrevs:
  |                { [] }
  | abbrevs abbrev { $2 :: $1 }

abbrev:
  | SINGLE_QUOTED COLON SUBJECT COLON SINGLE_QUOTED ISSUER COLON SINGLE_QUOTED
     { (without_quotes $1, 
        Id.{ subject = DN.make_exn (without_quotes $5);
             issuer = DN.make_exn (without_quotes $8)
        })
     }

clauses:
  | clause { [$1] }
  | clause clauses { $1 :: $2 }

clause:
  | literal DOT { Clast.Clause ($1, []) }
  | literal IF attested_literals DOT { Clast.Clause ($1, $3) }

attested_literals:
  | attested_literal { [$1] }
  | attested_literal COMMA attested_literals { $1 :: $3 }

attested_literal:
  | literal { Clast.Unattested $1 }
  | principal ATTESTS literal 
     { Clast.Attested (current_location (), $1, $3) }

literal:
  | LOWER_WORD { Clast.Atom ($1, []) }
  | LOWER_WORD LEFT_PARENTHESIS args RIGHT_PARENTHESIS
    { Clast.Atom ($1, $3) }
  | term LT term   { Clast.Atom ("lt", [$1; $3]) }
  | term LE term   { Clast.Atom ("le", [$1; $3]) }
  | term GT term   { Clast.Atom ("gt", [$1; $3]) }
  | term GE term   { Clast.Atom ("ge", [$1; $3]) }
  | term EQ term   { Clast.Atom ("eq", [$1; $3]) }
  | term NE term   { Clast.Atom ("ne", [$1; $3]) }

query:
  | LEFT_PARENTHESIS args RIGHT_PARENTHESIS IF signed_literals
    {
      let pos_literals, neg_literal = $5 in
      Clast.Query ($2, pos_literals, neg_literal)
    }

signed_literals:
  | literal COMMA signed_literals
    { let pos, neg = $3 in $1 :: pos, neg }
  | NOT literal COMMA signed_literals
    { let pos, neg = $4 in pos, $2 :: neg }
  | literal { [$1], [] }
  | NOT literal { [], [$2] }

args:
  | term { [$1] }
  | term COMMA args  { $1 :: $3 }

term:
  | INT { Clast.Const $1 }
  | LOWER_WORD { Clast.Const $1 }
  | UPPER_WORD { Clast.Var $1 }
  | SINGLE_QUOTED { Clast.Quoted $1 }

principal:
  | UPPER_WORD { Clast.PrincipalVar $1 }
  | SINGLE_QUOTED { Clast.PrincipalName (without_quotes $1) }
