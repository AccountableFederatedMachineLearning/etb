import React from 'react';
import io from 'socket.io-client';
import { initDb, addClaim } from './FactDB';

class ETBListener extends React.Component {
  constructor(props) {
    super(props);
    this.state = initDb;
  }

  componentDidMount() {
    var socket = io("http://localhost:5000");
    var etbListener = this;
    console.log(socket);

    socket.on('fact', (msg) =>
      etbListener.setState(db => {
        const db1 = { ...db }
        addClaim(db1, msg);
        return db1
      }));

    socket.on('all_facts', (msg) => {
      etbListener.setState(db => {
        const db1 = { ...db }
        for (const fact of msg) {
          addClaim(db1, fact)
        }
        return db1;
      })
    })
  }

  render() {
    return <></>
  }
}


export default ETBListener;