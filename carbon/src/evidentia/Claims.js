import React from 'react';
import Checkmark16 from '@carbon/icons-react/lib/checkmark/16';
import WarningAlt16 from '@carbon/icons-react/lib/warning--alt/16';
import { getClaims, getFirstCN } from './FactDB';

function jsonOfConstant(s) {
  if (s[0] === '\'' && s[s.length - 1] === '\'') {
    s = s.substring(1, s.length - 1);
  }
  try {
    return JSON.parse(s);
  }
  catch (e) {
    return null
  }
}

function claimText(claim) {
  let text = "";
  if (claim !== undefined) {
    if (claim.principal !== undefined) {
      text += `${getFirstCN(claim.principal.subject)} attests `;
    }
    if (claim.symbol !== undefined) {
      text += claim.symbol;
    }
    if (claim.args !== undefined) {
      text += `(${claim.args.join(", ")})`;
    }
  }
  return text;
}

function ClaimFail(props) {
  let reason = (props.reason !== undefined) ? props.reason : "";

  const claim = props.claim;
  if (claim !== undefined) {
    reason = claimText(claim);
  }
  return <span title={reason}><WarningAlt16 className="red" /></span>
}

function Instances(props) {
  const claims = getClaims(props.db, props.symbol, props.principal);
  if (claims.length > 0) {
    if (props.children) {
      return props.children(claims);
    }
  } else {
    return props.empty;
  }
}

function Expected(props) {
  let children = props.children;
  if (children === undefined) {
    children = claims => claims.map(claim =>
      <ClaimOk claim={claim} key={JSON.stringify(claim)} />)
  }

  return <Instances db={props.db} symbol={props.symbol} principal={props.principal}
    empty={<ClaimFail reason={claimText(props) + " is not derivable"} />}>
    {children}
  </Instances>
}

function NotExpected(props) {
  let children = props.children;
  if (children === undefined) {
    children = claims => claims.map(claim => <ClaimFail claim={claim} />)
  }

  return <Instances db={props.db} symbol={props.symbol} principal={props.principal}
    empty={<ClaimOk reason={claimText(props) + " is not derivable"} />}>
    {children}
  </Instances>
}


function ClaimOk(props) {
  let reason = (props.reason !== undefined) ? props.reason : "";
  var styleClass = "green";

  const claim = props.claim;
  if (claim !== undefined) {
    reason = claimText(claim);
    if (claim.colors.has("green")) {
      styleClass = "green"
    } else if (claim.colors.has("yellow")) {
      styleClass = "yellow"
    } else {
      styleClass = ""
    }
  }
  return <span title={reason}><Checkmark16 className={styleClass} /></span>
}

export { ClaimOk, ClaimFail, Instances, Expected, NotExpected, jsonOfConstant }
