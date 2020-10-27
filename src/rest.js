const express = require('express')
const fabric = require('./fabric')
const test = require('./test.bs')
const app = express()
const port = 3000

var db;

app.get('/', (req, res) => {
  try {
    const lit = test.Parser.parse_literal("a(647, 3");
  } catch (err) {
    console.log("Parsing error at line " + err.line + ", column " + err.column);
    res.send("Parsing error.")
    return;
  }
  test.ETB.add_fact(db, lit);
  res.send("Done");
})

app.listen(port, async () => {
  console.log(`Example app listening at http://localhost:${port}`);
  var prg;
  try {
    prg = test.Parser.parse_file("a(43, 4) :- a(43, 3). a(43, 3) :- a(43, 2). a(43, 2) :- a(43, 1). a(43, 1).");
  } catch (err) {
    console.log("Parsing error at line " + err.line + ", column " + err.column);
    res.send("Parsing error.")
  }
  db = test.ETB.create(prg);
  const contract = await fabric.connect();
  test.ETB.connect_to_contract(db, contract);
})

