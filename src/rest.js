const fs = require('fs')
const express = require('express')
const fabric = require('./fabric')
const syntax = require('./syntax.bs')
const id = require('./id.bs')
const logicService = require('./logicService.bs')
const rest = require('./rest.bs')
const app = express()
var http = require('http').createServer(app);
var io = require('socket.io')(http);

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
    const pem = await fabric.getUserCertificate();
    const userId = id.of_x509_certificate_exn(pem);
    const prg = syntax.Cyberlogic.parse_file_exn(userId, source);
    db = logicService.create(userId, prg);
  } catch (err) {
    if (err.msg !== undefined && err.line !== undefined && err.column !== undefined) {
      console.log(err.msg + " at line " + err.line + ", column " + err.column);
    } else {
      console.log(err);
    }
    return;
  }

  // Register REST endpoints

  app.get('/', (req, res) => {
    res.sendFile(__dirname + "/index.html");
  })

  app.get('/facts', async (req, res) => {
    const response = await rest.facts_get(db);
    res.send(response)
  })

  app.put('/facts/:fact', async (req, res) => {
    const response = await rest.facts_put(db, req.params.fact);
    return res.send(response)
  })

  app.put('/goals/:goal', async (req, res) => {
    const response = await rest.goal_put(db, req.params.goal);
    return res.send(response)
  })

  io.on('connection', (socket) => {
    console.log('a user connected');
    let msg = "dsd";
    io.emit('test', msg);
    socket.on('test', (msg) => {
      io.emit('test', msg);
    });
  });

  // http.listen(3000, () => {
  //   console.log('listening on *:3000');
  // });

  http.listen(port, async () => {
    console.log(`Listening at http://localhost:${port}`);
    const contract = await fabric.connect();
    logicService.connect_to_contract(db, contract);
  })
}

main()
