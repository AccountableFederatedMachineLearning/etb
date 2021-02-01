import React from 'react';
import io from 'socket.io-client';
import { initDb, addClaim } from './FactDB';

class ETBListener extends React.Component {
  constructor(props) {
    super(props);
    this.state = initDb;
  }

  componentDidMount() {
    var socket = io();
    var etbListener = this;
    console.log(socket);
    socket.on('fact', (msg) =>
      etbListener.setState(db => addClaim(db, msg)))
  }

  render() {
    return <></>
  }
}


export default ETBListener;