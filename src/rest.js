const fs = require('fs')
const express = require('express')
const fabric = require('./fabric')
const logger = require('./logger.bs')
const cyberlogic = require('./cyberlogic/cyberlogic.bs')
const syntax = require('./syntax.bs')
const id = require('./id.bs')
const logicService = require('./logicService.bs')
const rest = require('./rest.bs')
const app = express();
const bodyParser = require('body-parser');
var http = require('http').createServer(app);
var io = require('socket.io')(http, {
  cors: {
    origin: '*',
  }
});

const fact_event = 'fact';
const all_facts_event = 'all_facts';

async function main() {
  var args = process.argv.slice(2);

  // First argument must be source file
  if (args.length < 2) {
    console.error("Usage: main <userId> <datalog_source.dl> [port]");
    process.exit(1)
  }
  const walletId = args[0];
  const sourceFile = args[1];

  // Second argument may be port
  var port = 5000
  if (args.length > 2) {
    port = args[2]
  }

  // Load source file
  var source;
  try {
    source = fs.readFileSync(sourceFile).toString()
    logger.debug("Using the following source code\n" + source);
  } catch (err) {
    console.error("Cannot read file '" + sourceFile + "'.");
    console.error(err.message);
    process.exit(1)
  }

  // Parse and construct the logic service
  var db;
  try {
    const pem = await fabric.getUserCertificate(walletId);
    const userId = id.of_x509_certificate_exn(pem);
    const prg = syntax.Cyberlogic.parse_file_exn(userId, source);
    db = logicService.create(userId, prg);
  } catch (err) {
    if (err.msg !== undefined && err.line !== undefined && err.column !== undefined) {
      console.error(err.msg + " at line " + err.line + ", column " + err.column);
    } else {
      console.error(err);
    }
    return;
  }

  app.use(bodyParser.json());

  // Register REST endpoints
  const carbonDir = __dirname + '/../carbon/build';
  if (fs.existsSync(carbonDir)) {
    app.use(express.static(carbonDir));
  } else {
    app.use(express.static(__dirname + '/html'));
  }

  app.get('/facts', async (req, res) => {
    const response = await rest.facts_get(db);
    res.send(response)
  })

  app.post('/facts/add', async (req, res) => {
    const response = await rest.facts_put(db, req.body.fact);
    return res.send(response)
  })

  app.post('/goals/add', async (req, res) => {
    const response = await rest.goal_put(db, req.body.goal);
    return res.send(response)
  })

  io.on('connection', async (socket) => {
    logger.info('a user connected');
    let facts = await rest.facts_get(db);
    const fact_array = [];
    for (const fact of facts) {
      fact_array.push(fact);
    }
    io.emit(all_facts_event, fact_array);
  });

  logicService.add_fact_listener(db, (fact) => {
    let json_fact = cyberlogic.Literal.to_json(fact);
    io.emit(fact_event, json_fact);
  })

  http.listen(port, async () => {
    logger.info(`Listening at http://localhost:${port}`);
    var contract;
    try {
      contract = await fabric.connect(walletId);
    } catch (err) {
      console.error("Cannot connect to hyperledger.");
      console.error(err);
      process.exit(1);
    }
    logicService.connect_to_contract(db, contract);
  })
}

main()
