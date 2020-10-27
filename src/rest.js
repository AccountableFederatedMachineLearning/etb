const express = require('express')
const fabric = require('./fabric')
const syntax = require('./syntax.bs')
const logicService = require('./logicService.bs')
const rest = require('./rest.bs')
const app = express()
const port = 3000

var db;

app.get('/', (req, res) => {
  res.send("Okay");
})

app.get('/facts', async (req, res) => {
  const response = await rest.facts_get(db);
  res.send(response)
})

app.put('/facts/:fact', async (req, res) => {
  const response = await rest.facts_put(db, req.params.fact);
  return res.send(response)
})

app.listen(port, async () => {
  console.log(`Listening at http://localhost:${port}`);
  var src = `
    a(43, 4) :- a(43, 3).
    a(43, 3) :- a(43, 2).
    a(43, 2) :- a(43, 1).
    a(43, 1).
  `;
  try {
    prg = syntax.parse_file_exn(src);
  } catch (err) {
    console.log("Parsing error at line " + err.line + ", column " + err.column);
    return;
  }
  db = logicService.create(prg);
  const contract = await fabric.connect();
  logicService.connect_to_contract(db, contract);
})

