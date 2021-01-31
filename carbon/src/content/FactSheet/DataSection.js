import React from 'react';
import {
  UnorderedList,
  CodeSnippet,
  ListItem,
} from 'carbon-components-react';
import { Instances, ClaimOk, ClaimFail, jsonOfConstant, getFirstCN } from '../../evidentia';

const DataSection = props =>
  <>
    <h2 id="data" className="fact-sheet__subheading">
      Data
                      </h2>

    <p className="fact-sheet__p">
      This section gives information about the data used by the participants.
    </p>

    <UnorderedList>
      <Instances db={props.db}
        symbol="configuration"
        empty={<ListItem>Information about the data is (still) missing.<ClaimFail /></ListItem>}>
        {claims =>
          claims.map(claim => {
            let config = jsonOfConstant(claim.args[0]);
            if (config.data.info === undefined) {
              return null;
            } else {
              return <React.Fragment key={JSON.stringify(claim)}>
                <ListItem>
                  {getFirstCN(claim.principal.subject)} records the following information about the used data:
                  <ClaimOk claim={claim} />
                  <CodeSnippet type="single" hideCopyButton={true}>
                    {JSON.stringify(config.data.info)}
                  </CodeSnippet>
                </ListItem>
              </React.Fragment>
            }
          })}
      </Instances>
    </UnorderedList>

    <p className="fact-sheet__p">
    </p>

    {/* ---------------------------------------- */}
    <h3 className="fact-sheet__subsubheading">Identity of Training Data</h3>

    <p className="fact-sheet__p">
      To make the training process reproducible, the participants have recorded hashes
      of their training data.
                      </p>

    <UnorderedList>
      <Instances db={props.db}
        symbol="training_data_hash"
        empty={<ListItem>Information about the fusion algorithm it (still) missing.<ClaimFail /></ListItem>}>
        {claims =>
          claims.map(claim =>
            <ListItem key={JSON.stringify(claim)}>
              The training data of {getFirstCN(claim.principal.subject)} has the following hash.
              <ClaimOk claim={claim} />
              <CodeSnippet type="single" hideCopyButton={true}>
                {claim.args[0]}
              </CodeSnippet>
            </ListItem>
          )}
      </Instances>
    </UnorderedList>

    <p className="fact-sheet__p">
    </p>

    {/* ---------------------------------------- */}
    <h3 className="fact-sheet__subsubheading">Identity of Training Data Labels</h3>

    <p className="fact-sheet__p">
      To make the training process reproducible, the participants have recorded hashes
      of their training data.
                      </p>

    <UnorderedList>
      <Instances db={props.db}
        symbol="training_data_labels_hash"
        empty={<ListItem>Information about the fusion algorithm it (still) missing.<ClaimFail /></ListItem>}>
        {claims =>
          claims.map(claim =>
            <ListItem key={JSON.stringify(claim)}>
              The training label data of {getFirstCN(claim.principal.subject)} has the following hash.
            <ClaimOk claim={claim} />
              <CodeSnippet type="single" hideCopyButton={true}>
                {claim.args[0]}
              </CodeSnippet>
            </ListItem>
          )}
      </Instances>
    </UnorderedList>

    <p className="fact-sheet__p">
    </p>

  </>

export { DataSection }