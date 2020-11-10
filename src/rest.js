const fs = require('fs')
const express = require('express')
const fabric = require('./fabric')
const syntax = require('./syntax.bs')
const id = require('./id.bs')
const logicService = require('./logicService.bs')
const rest = require('./rest.bs')
const app = express()

async function main() {
  var args = process.argv.slice(2);

  // First argument must be source file
  if (args.length < 1) {
    console.error("Usage: main <file.dl> [port]");
    process.exit(1)
  }
  const sourceFile = args[0];

  // Second argument may be port
  var port = 3000
  if (args.length > 1) {
    port = args[1]
  }

  // Load source file
  var source;
  try {
    source = fs.readFileSync(sourceFile).toString()
    console.log("Clauses");
    console.log(source);
  } catch (err) {
    console.error("Cannot read file '" + sourceFile + "'.");
    console.error(err.message);
    process.exit(1)
  }

  // Parse and construct the logic service
  var db;
  try {
    const prg = syntax.Datalog.parse_file_exn(source);
    const pem = await fabric.getUserCertificate();
    const userId = id.of_x509_certificate_exn(pem);
    db = logicService.create(prg, userId);
  } catch (err) {
    console.log("Parsing error at line " + err.line + ", column " + err.column);
    console.log(err);
    return;
  }

  // Register REST endpoints

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
    const contract = await fabric.connect();
    logicService.connect_to_contract(db, contract);
  })
}

main()
