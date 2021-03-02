import React from 'react';
import {
  UnorderedList,
  ListItem,
  StructuredListWrapper,
  StructuredListHead,
  StructuredListBody,
  StructuredListRow,
  StructuredListInput,
  StructuredListCell,
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

    <StructuredListWrapper className="fact-sheet__structured-list"
      ariaLabel="Structured list">
      <StructuredListHead>
        <StructuredListRow
          head
          tabIndex={0}
        >
          <StructuredListCell head>
            Checked Property
          </StructuredListCell>
          <StructuredListCell head>
            Description
          </StructuredListCell>
        </StructuredListRow>
      </StructuredListHead>
      <StructuredListBody>
        <StructuredListRow tabIndex={0}>
          <StructuredListCell>
            All model-updates received by the aggregator were also sent by a party.
        <Expected db={props.db} symbol="received_messages_were_all_sent" />
          </StructuredListCell>
          <StructuredListCell>
            It has been verified that each model update that the aggregator
            claims to have received is claimed to have been sent by some party.
            The updates are identified by their SHA-512 hash.
          </StructuredListCell>
        </StructuredListRow>
        <StructuredListRow tabIndex={0}>
          <StructuredListCell>
            Aggregator received all model updates that were sent by the
            parties.
            <NotExpected db={props.db}
              symbol="message_not_received"
              expected={false} />
          </StructuredListCell>
          <StructuredListCell>
            This means that for each model update that some party claims to have
            sent, there is a matching claim by the aggregator that this update
            has been received.
          </StructuredListCell>
        </StructuredListRow>
        {/* <StructuredListRow tabIndex={0}>
          <StructuredListCell>
            All parties have acknowledged that they are satisfied with the
            logged infomation.
          </StructuredListCell>
          <StructuredListCell>
            All parties continuously receive updates of the data that is
            recorded on the tamper-proof log. Once they were satisfied that,
            from their point of view, all necessary data has appeard on the
            log, they have acknowledged this with an acknowledgment log entry.
          </StructuredListCell>
        </StructuredListRow> */}
      </StructuredListBody>
    </StructuredListWrapper>

    <Instances db={props.db} symbol="forbidden"
      empty="">
      {claims =>
        <p className="fact-sheet__p">
          <Problems db={props.db} key="forbidden" />
        </p>
      }
    </Instances>
  </>

export { StatusSection }