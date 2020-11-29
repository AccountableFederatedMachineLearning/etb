
# Dependencies

The project should compile on Linux and only need an installation
of Node.js. I am using Fedora 33 and Ubuntu 20.20 with the included
node packages.

Install dependencies with:
```
npm install
```

# Build

The project can be built with:
```
npm run build
```

For development, it is useful to start a continuous build process
that triggers recompilation on each file change:
```
npm run watch
```

# Configuration

For the connection to Hyperledger Fabric, the following information
must be specified in `src/config.js`:

- Connection profile path
- Wallet path
- Hyperledger channel name
- Hyperledger chaincode name

# Running

The main program starts a REST service for interacting with the node.
It may be started as follows:
```
  node src/rest.js <principalName> <datalog_file.dl> [port]
```  
The principal name `principalName` must be the name of an identity
in the wallet. It is the identity with which the node connects to
the chain.

## Example

Start an example node:
```
  node src/rest.js appUser examples/b.dl 5000
```

In a second terminal, start
```
  node src/rest.js appUser examples/a.dl 5001
```  

If the connection to hyperledger succeeds, the two nodes should start
interacting with each other.


# REST interface

- `http GET localhost:5000` provides a status page that can be used to
track updates

- `http GET localhost:5000/facts` lists all facts on the node in JSON format

- `http PUT localhost:5000/facts/"test('dbs sd', 3)"` submits a new claim to the node. The principal is the user id with which the node was 
started.

<!--
- `http PUT localhost:5000/goals/"test(X, 3)"` submits a query.
Currently, this triggers backchaining, but it is not connected to 
anything.
-->

# Syntax of Logic Programs

It is possible to specify simple datalog clauses, e.g.;
```prolog
a('test', 1).
a('test', 3) :- b('test', 2). 
a('test', 5) :- b('test', 4). 
```
The claims in this program do not mention a principal. They are
implicitly treated as claims of the principal that runs the node.

It is possible to refer to other principals. Principals are identified
by the subject and issuer fields in the X.509 certificate that they are using to access Hyperledger.
Here is an example to show the syntax:
```prolog
'user1':
  Subject: 'OU=client+OU=org1+OU=department1,CN=appUser1'
  Issuer: 'C=US,ST=North Carolina,L=Durham,O=org1.example.com,CN=ca.org1.example.com'
'user2':
  Subject: 'OU=client+OU=org1+OU=department1,CN=appUser2'
  Issuer: 'C=US,ST=North Carolina,L=Durham,O=org1.example.com,CN=ca.org1.example.com'

b(1) :- 'user1' says b(1), 'user2' says b(1).
```

Note that, by design, a node cannot make claims for other users. 
It therefore does not make sense to have clauses whose conclusion is
a claim for a principal other than the one running the node
(this requirement should be checked during parsing, but isn't currently).

# TODOs

- When started, the node should probably read existing facts from
  the ledger. Currently, it starts from an empty database.

- Check that programs contain only clauses with claims for the 
  principal running the node.

- Add more primitive operations, for integers, JSON, ...