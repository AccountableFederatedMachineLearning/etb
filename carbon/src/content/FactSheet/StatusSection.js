import React from 'react';
import {
  UnorderedList,
  CodeSnippet,
  ListItem,
} from 'carbon-components-react';
import { Instances, Expected, NotExpected, ClaimOk, ClaimFail, jsonOfConstant } from '../../evidentia';


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
      This FactSheet documents the evidence that all the participants have correctly
      followed the federated machine learning process.
      <Expected db={props.db} symbol="required" />
    </p>

    <p className="fact-sheet__p">
      The following consistency requirements have been verified:
    </p>
    <UnorderedList>
      <ListItem>
        All model-updates that the aggregator received were sent by a party.
        <Expected db={props.db} symbol="received_messages_were_all_sent" />
      </ListItem>
      <ListItem>
        All the messages sent by a party were received by the aggregator.
        <NotExpected db={props.db}
          symbol="message_not_received"
          expected={false} />
      </ListItem>
      <ListItem>
        All parties have provided hashes of their datasets.
      </ListItem>
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