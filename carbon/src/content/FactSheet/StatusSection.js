import React from 'react';
import {
  UnorderedList,
  ListItem,
} from 'carbon-components-react';
import { Instances, Expected, NotExpected } from '../../evidentia';


// TODO
function Problems(props) {
  if (props.db === undefined) {
    return null;
  }
  return (<>
    <h2 style={{ color: "red" }}>Problems found</h2>
    <UnorderedList>
      <NotExpected db={props.db} symbol="message_not_received">
        {claims =>
          <ListItem>"Some model updates were sent but not received:"
          <NotExpected db={props.db} symbol="not_received">
              {cs => cs.map(c => c.args[0])}
            </NotExpected>
          </ListItem>}
      </NotExpected>
    </UnorderedList>
  </>
  );
}

const StatusSection = props =>
  <>
    <h2 id="status" className="fact-sheet__subheading">
      Status
    </h2>

    <p className="fact-sheet__p">
      This section documents the consistency checks that have been performed
      to verify the federated machine learning process.
      <Expected db={props.db} symbol="required" />
    </p>

    <p className="fact-sheet__p">
         In each round, all parties use their data to train a model update.
        They send their updates to the aggregator, who combines them.
        Both the parties and the aggregator use Evidentia plugin to record 
        a hash of the data that they have sent or received.
    </p>
    <UnorderedList>
      <ListItem>
        All model-updates that the aggregator received were sent by a party.
        <Expected db={props.db} symbol="received_messages_were_all_sent" />
        <br/>
        This means that it has been verified that each model update
        that the aggregator claims to have received is claimed to have been
        sent by some party.
      </ListItem>
      <ListItem>
        All the messages sent by a party were received by the aggregator.
        <NotExpected db={props.db}
          symbol="message_not_received"
          expected={false} />
        <br/>
        This means that each model update that some party claims to have
        sent is also claimed to be received by the aggregator.
      </ListItem>
      {/* <ListItem>
        All parties have provided hashes of their datasets.
      </ListItem> */}
    </UnorderedList>

    <p className="fact-sheet__p">
      <Instances db={props.db} symbol="forbidden"
        empty="">
        {claims =>
          <Problems db={props.db} key="forbidden" />
        }
      </Instances>
    </p>
  </>

export { StatusSection }