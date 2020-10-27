const express = require('express')
const fabric = require('./fabric')
const datalogParser = require('./datalogParser.bs')
const logicService = require('./logicService.bs')
const app = express()
const port = 3000

var db;

app.get('/', (req, res) => {
  try {
    const lit = datalogParser.literal_exn("a(647, 3");
  } catch (err) {
    res.send("Parsing error at line " + err.line + ", column " + err.column)
    return;
  }
  test.ETB.add_fact(db, lit);
  res.send("Okay");
})

app.listen(port, async () => {
  console.log(`Listening at http://localhost:${port}`);
  var prg;
  try {
    prg = datalogParser.file_exn("a(43, 4) :- a(43, 3). a(43, 3) :- a(43, 2). a(43, 2) :- a(43, 1). a(43, 1).");
  } catch (err) {
    console.log("Parsing error at line " + err.line + ", column " + err.column);
    return;
  }
  db = logicService.create(prg);
  const contract = await fabric.connect();
  logicService.connect_to_contract(db, contract);
})

