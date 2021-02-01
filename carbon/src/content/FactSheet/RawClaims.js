import React from 'react';
import {
  UnorderedList,
  ListItem,
} from 'carbon-components-react';
import { Instances, getFirstCN } from '../../evidentia';

export function RawClaims(props) {
  if (props.db === undefined) {
    return null;
  }
  return <UnorderedList>{
    Object.keys(props.db.claims).map(symbol =>
      <React.Fragment key={symbol}>
        <h2 className="fact-sheet__subsubheading" key={symbol}>
          Facts with symbol '{symbol}'
          </h2>
        <Instances db={props.db} symbol={symbol}>
          {claims =>
            <UnorderedList>
              {claims.map(claim =>
                <ListItem key={JSON.stringify(claim)}>
                  {getFirstCN(claim.principal.subject)}
                  attests
                  {claim.symbol}({claim.args.join(", ")})
                </ListItem>)}
            </UnorderedList>
          }
        </Instances>
      </React.Fragment>)}
  </UnorderedList>;
}

export default RawClaims