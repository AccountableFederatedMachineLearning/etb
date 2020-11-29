Summarize 'old' approach

Summarize proposal:

- Interface of components

![Alt text](./images/test.drawio.svg)

==

Do we need a blockchain?

Roles:
- ETB: prover
- DEN: proof database and proof checker

Chain:
- Data layout:
  - facts: the database of 'public' facts of each id
  - clause: the allowed workflows of each id  (the rules that the auditor wants to verify)
    (TODO: adding and removing clauses? several, perhaps parallel, runs of an application?
     TODO: maybe allow sessions, e.g. instantiating clauses with param for session-id
     TODO: should this be a notion of resource?)
  - registry of servers: list of addresses of servers for each id 
    (TODO: installed by coordinator, as before?)
- Code:
  - AddFact: Adds a fact with the id of the submitter, either with given evidence or otherwise
    derivable from existing facts on the chain.
    (TODO: contract should perform proof checking)

Failure scenarios
- some nodes fail
- some nodes are malicious
- some private keys are leaked

External certificates
- Who should issue them?
- Verification, e.g. wrt to certificate revocation

Trust:
- Why can I trust the hyperledger database
  - Consensus gives evidence that the proof checker wasn't tampered with
  - Signatures make manipulation of blocks hard

Accountability
- list of actions to retrace steps

TODOs:
- Record user identity when logging
- list of actions to retrace steps
- remote queries
- retry transactions on failure