import React from 'react';
import {
  UnorderedList,
  ListItem,
} from 'carbon-components-react';
import { LineChart } from "@carbon/charts-react";
import "@carbon/charts/styles.css";
import { Instances, ClaimOk, ClaimFail, jsonOfConstant, getFirstCN } from '../../evidentia';

const chartOptions = {
  "title": "Model Performance Evolution",
  "axes": {
    "bottom": {
      "title": "Round",
      "mapsTo": "key",
      "scaleType": "labels"
    },
    "left": {
      "mapsTo": "value",
      "title": "Performance",
      "scaleType": "linear"
    }
  },
  "height": "400px"
}

const ModelSection = props =>
  <>
    <h2 id="modelinformation" className="fact-sheet__subheading">
      Model Information
    </h2>

    <p className="fact-sheet__p">
    </p>

    <Instances db={props.db} symbol="configuration"
      empty={<>Information about the configuration of participants is (still) missing.<ClaimFail /></>}>
      {claims =>
        claims.map(claim => {
          let config = jsonOfConstant(claim.args[0]);
          return <React.Fragment key={JSON.stringify(claim)}>
            <h3 className="fact-sheet__subsubheading">
              Model details of {getFirstCN(claim.principal.subject)}
              <ClaimOk claim={claim} />
            </h3>

            <UnorderedList>
              <ListItem> Model name: <tt>{config?.model?.spec?.model_name}</tt> </ListItem>
              <ListItem> Model definition: <tt>{config?.model?.spec?.model_definition}</tt> </ListItem>
              <ListItem> Class reference: <tt>{config?.model?.cls_ref}</tt> </ListItem>
            </UnorderedList>
          </React.Fragment>
        })}
    </Instances>

    <p className="fact-sheet__p">
      The following graph shows the evolution of the performance of the model
      over the rounds, as reported by the aggregator.
    </p>

    <Instances db={props.db} symbol="evaluation_results"
      // principal="aggregator"
      empty={<>Performance information not (yet) available.<ClaimFail /></>}>
      {claims => {
        const accData = claims.map(claim => ({ group: "accuracy", key: claim.args[0], value: jsonOfConstant(claim.args[1])?.acc }));
        const f1MicroData = claims.map(claim => ({ group: "f1 micro", key: claim.args[0], value: jsonOfConstant(claim.args[1])["f1 micro"] }));
        accData.sort((a, b) => a.key - b.key);
        f1MicroData.sort((a, b) => a.key - b.key);
        const data = accData.concat(f1MicroData);
        return <LineChart className="fact-sheet__chart" data={data} options={chartOptions} />
      }}
    </Instances>

    <p className="fact-sheet__p">
    </p>

  </>

export { ModelSection }