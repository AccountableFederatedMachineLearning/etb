import React from 'react';
import io from 'socket.io-client';
import { initDb, addClaim } from './FactDB';

class ETBListener extends React.Component {
  constructor(props) {
    super(props);
    this.state = initDb;
    this.newDb = undefined;
  }

  applyUpdates() {
    var etbListener = this;
    setTimeout(() => {
      if (etbListener.newDb !== undefined) {
        etbListener.setState(etbListener.newDb);
        etbListener.newDb = undefined;
      }
      this.applyUpdates();
    }, 1000);
  }

  componentDidMount() {
    var socket = io();
    var etbListener = this;
    console.log(socket);

    socket.on('fact', (msg) => {
      if (etbListener.newDb === undefined) {
        etbListener.newDb = { ...etbListener.state }
      }
      addClaim(etbListener.newDb, msg);
    });

    socket.on('all_facts', (msg) => {
      etbListener.setState(db => {
        const db1 = { ...db }
        for (const fact of msg) {
          addClaim(db1, fact)
        }
        return db1;
      })
    })
    this.applyUpdates();
  }

  render() {
    return <></>
  }
}


export default ETBListener;