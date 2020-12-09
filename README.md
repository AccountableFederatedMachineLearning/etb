# Dependencies

The project should compile on Linux and only need an installation
of Node.js. I am using Fedora 33 and Ubuntu 20.10 with the included
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

The chaincode should implement the transaction `Claim`, as 
implemented in [hyperledger](hyperledger).

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

- `http POST localhost:5000/facts/add fact="test('dbs sd', 3)"` submits a 
  new claim to the node. The principal is the user id with which the node 
  was started.

- `http POST localhost:5000/goals/add goal="test(X, 3)"` adds a 
  goal of the given form.
  This is useful to trigger backchaining, since not *all* consequences
  of all rules are computed automatically. For example, suppose one has
  a program with the following clause:

    ```prolog
      a(X) :- b(Y), length(Y, X)
    ```

  If one adds the fact `b('[1,2,3]')`, then the clause can derive `a(3)`.
  By default, this does not happen automatically, since instances of
  `length(Y, X)` are only added on demand. The implementation does
  not know in advance that it will need `length([1,2,3], 3)`, even though
  it knows how to add it when needed.
  
  However, one can make `a(X)` a goal. Then, after each change to the 
  database, the engine will then check by
  backchaining what needs to be proved to establish `a(X)`. It will
  add suitable instances of `length(Y, X)` as required.

# Syntax of Logic Programs

It is possible to specify simple datalog clauses, e.g.;
```prolog
a('test', 1).
a('test', 3) :- b('test', 2). 
a('test', 5) :- b('test', 4). 
```
The claims in this program do not mention a principal. They are
implicitly treated as claims of the principal that runs the node.

## Principals

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

It is also possible to use principal variables.
```
b(1) :- 'user1' says b(1), P says b(1).
```

Note that, by design, a node cannot make claims for other users. 
It therefore does not make sense to have clauses whose conclusion is
a claim for a principal other than the one running the node.
This is in fact a syntax error.

## JSON

The following operations on JSON-values are currently 
implemented:

- `length(json_array, len)`: Length of JSON arrays. 
   For example, we have `length('[1, 2, 3]', 3)`.

- `array_get(json_array, index, value)`: Accessing fields of JSON objects.
   For example, we have `array_get('[1, 2, 3]', 2, 3)`.

- `object_get(json_object, field, value)`: Accessing fields of JSON objects.
   For example, we have `object_get('{"test": 4}', 'test', 4)`.

## Integers

The following operations for working with ints are currently 
implemented. (more to be added by need)

- `i < j`, `i <= j`, `i > j`, `i >= j`: Order relations between intergers.

- `add(i, j, n)`, `mul(i, j, n)`: Addition and Multiplication.

## General

Equality and disequality *of constants*:

- `c == d` and `c != d`.

# TODOs

- When started, the node should probably read existing facts from
  the ledger. Currently, it starts from an empty database.

- Add more primitive operations, improve syntax.
