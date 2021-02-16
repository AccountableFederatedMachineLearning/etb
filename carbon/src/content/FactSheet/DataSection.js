import React from 'react';
import {
  UnorderedList,
  CodeSnippet,
  ListItem,
} from 'carbon-components-react';
import { GroupedBarChart } from "@carbon/charts-react";
import { Instances, ClaimOk, ClaimFail, jsonOfConstant, getFirstCN, getClaims } from '../../evidentia';

const chartOptions = {
  "axes": {
    "left": {
      "mapsTo": "value"
    },
    "bottom": {
      "scaleType": "labels",
      "mapsTo": "key"
    }
  },
  "height": "400px"
}

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
            if (config?.data?.info === undefined) {
              return null;
            } else {
              return <React.Fragment key={JSON.stringify(claim)}>
                <ListItem>
                  {getFirstCN(claim.principal.subject)}
                  records the following information about the used data:
                  <ClaimOk claim={claim} />
                  <CodeSnippet type="single" hideCopyButton={true}>
                    {JSON.stringify(config?.data?.info)}
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
    <h3 className="fact-sheet__subsubheading">
      Training Data Labels
    </h3>

    <p className="fact-sheet__p">
      The following graph shows the number of data samples per label in the training data.
    </p>

    <Instances db={props.db} symbol="training_data_count_per_label"
      // principal="aggregator"
      empty={<>Training data label information not (yet) available.<ClaimFail /></>}>
      {claims => {
        const data = claims.map(claim => {
          const subject = getFirstCN(claim.principal.subject)
          const labelNamesClaim = getClaims(props.db, "labels_list", subject);
          var label = claim.args[0]
          if (labelNamesClaim[0]?.args[0] !== undefined) {
            const labelNames = jsonOfConstant(labelNamesClaim[0].args[0])
            label = labelNames[claim.args[0]]
          }
          return ({ group: subject, key: label, value: claim.args[1] })
        });
        data.sort((a, b) => a.key.localeCompare(b.key));
        return <GroupedBarChart className="fact-sheet__chart" data={data} options={chartOptions} />
      }}
    </Instances>

    <p className="fact-sheet__p">
    </p>


    {/* ---------------------------------------- */}
    <h3 className="fact-sheet__subsubheading">
      Identity of Training Data Labels
    </h3>

    <p className="fact-sheet__p">
      To make the training process reproducible, the participants have recorded SHA512-hashes
      of their training data labels.
    </p>

    <UnorderedList>
      <Instances db={props.db}
        symbol="training_data_labels_hash"
        empty={<ListItem>Information about the fusion algorithm it (still) missing.<ClaimFail /></ListItem>}>
        {claims =>
          claims.map(claim =>
            <ListItem key={JSON.stringify(claim)}>
              The training label data of {getFirstCN(claim.principal.subject)} has the following SHA512-hash.
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