import React from 'react';
import io from 'socket.io-client';
import {initDb, addClaim} from './FactDB';

class ETBListener extends React.Component {
  constructor(props) {
    super(props);
    this.state = initDb;
  }

  componentDidMount() {
    var socket = io('ws://localhost:5000');
//    var socket = io();
    var etbListener = this;
    console.log(socket);
    socket.on('fact', function (msg) {
      // console.log(msg);
      etbListener.setState(db => addClaim(db, msg));
      // let facts = db.state;
      // let cn = getFirstCN(msg.principal.subject);
      // let symbolEntry = facts[msg.literal.symbol] || {};
      // let principalEntry = symbolEntry[cn] || {};
      // let args = JSON.stringify(msg.literal.arguments);
      // let argsEntry = principalEntry[args] || new Set();
      // argsEntry.add(msg.color);
      // principalEntry[args] = argsEntry;
      // symbolEntry[cn] = principalEntry;
      // facts[msg.literal.symbol] = symbolEntry;
      // db.setState(facts);
    });
  }

  render() {
    return <></>
  }
}


export default ETBListener;