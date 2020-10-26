type contract;
@bs.module("./fabric.js") external connect: unit => Js.Promise.t<contract> = "connect"
@bs.module("./test2.js") external main: unit => Js.Promise.t<unit> = "main"

open Default
let test = %raw(
  `
  async function(x) {
  const fs = require('fs', 'utf8');
  let s = await fs.promises.readFile(x);
  return s;
  }
`
)
test("src/test2.js")


main()->Js.Promise.then_(x => {
  Js.log("Hello, BuckleScript")

  let parse_clause = s => {
    let lex = Lexing.from_string(s)
    let ac = Parser.parse_clause(Lexer.token, lex)
    clause_of_ast(ac)
  }

  let c1 = parse_clause("q(X) :- p(1, X).")
  let c2 = parse_clause("q(3).")
  let l = mk_literal(StringSymbol.make("q"), list{mk_var(0)})
  let l1 = mk_literal(StringSymbol.make("s"), list{mk_var(1), mk_const(StringSymbol.make("y"))})
  pp_clause(Format.str_formatter, c1)
  Js.log(Format.flush_str_formatter())
  let db = db_create()
  db_add(db, c1)
  db_add(db, c2)
  let r = Query.ask(db, [0], list{l})
  Query.pp_plan(Format.str_formatter, r)
  Js.log(Format.flush_str_formatter())
  Js.Promise.resolve(x)
}, _)
