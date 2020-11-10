/*
this file is part of datalog. See README for the license
*/

%{
  let without_quotes quoted =
    String.sub quoted 1 (String.length quoted - 2)
%}

%token LEFT_PARENTHESIS
%token RIGHT_PARENTHESIS
%token DOT
%token IF
%token NOT
%token COMMA
%token SAYS
%token EQUALS
%token EOI
%token <string> SINGLE_QUOTED
%token <string> LOWER_WORD
%token <string> UPPER_WORD
%token <string> INT

%start parse_literal
%type <Clast.literal> parse_literal

%start parse_literals
%type <Clast.literal list> parse_literals

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

parse_literals:
  | literals EOI { $1 }

parse_clause:
  | clause EOI { $1 }

parse_query:
  | query EOI { $1 }

abbrevs:
  |                { [] }
  | abbrevs abbrev { $2 :: $1 }

abbrev:
  | SINGLE_QUOTED EQUALS principal { (without_quotes $1, $3) }

clauses:
  | clause { [$1] }
  | clause clauses { $1 :: $2 }

clause:
  | literal DOT { Clast.Clause ($1, []) }
  | literal IF literals DOT { Clast.Clause ($1, $3) }

literals:
  | literal { [$1] }
  | literal COMMA literals { $1 :: $3 }

literal:
  | LOWER_WORD { Clast.Atom ($1, []) }
  | LOWER_WORD LEFT_PARENTHESIS args RIGHT_PARENTHESIS
    { Clast.Atom ($1, $3) }
  | principal SAYS LOWER_WORD { Clast.Attestation ($1, $3, []) }
  | principal SAYS LOWER_WORD LEFT_PARENTHESIS args RIGHT_PARENTHESIS
    { Clast.Attestation ($1, $3, $5) }

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
  | SINGLE_QUOTED { without_quotes $1 }
