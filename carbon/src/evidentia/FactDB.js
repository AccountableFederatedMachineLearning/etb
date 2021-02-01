function getFirstCN(dn) {
  for (let i of dn) {
    if (i.CN) {
      return i.CN.join(".");
    }
  }
  return "?";
}

function getOU(dn) {
  var ous = [];
  for (let i of dn) {
    if (i.OU) {
      ous.push("OU=" + i.OU.join("+"));
    }
  }
  return ous.join(",");
}

const initDb = {
  claims: {},
  principals: []
};

function getPrincipal(db, principal) {
  let id = db.principals.findIndex(p => getFirstCN(p.subject) === getFirstCN(principal.subject));
  if (id < 0) {
    let db1 = {
      ...db,
      principals: [...db.principals, principal]
    }
    id = db1.principals.length - 1;
    return [id, db1]
  } else {
    return [id, db];
  }
}

function addClaim(db, msg) {
  let [cn, db1] = getPrincipal(db, msg.principal);
  let claims = db1.claims;
  let symbolEntry = claims[msg.literal.symbol] || {};
  let principalEntry = symbolEntry[cn] || {};
  let args = JSON.stringify(msg.literal.arguments);
  let argsEntry = principalEntry[args] || new Set();
  let newArgsEntry = new Set(argsEntry);
  newArgsEntry.add(msg.color);
  return {
    ...db1,
    claims: {
      ...claims,
      [msg.literal.symbol]: {
        ...symbolEntry,
        [cn]: {
          ...principalEntry,
          [args]: newArgsEntry
        }
      }
    }
  };
}

function getClaims(db, symbol, principalCN = undefined) {
  const facts = db.claims;
  if (facts[symbol] === undefined) {
    return [];
  }
  const principals = Object.keys(facts[symbol]).filter(p =>
    principalCN === undefined || getFirstCN(db.principals[p].subject) === principalCN
  );
  return principals.flatMap(p => {
    const colorsByArgs = facts[symbol][p];
    const allArgs = Object.keys(colorsByArgs).map(JSON.parse);
    return allArgs.map(args => {
      const colors = colorsByArgs[JSON.stringify(args)];
      return {
        symbol: symbol,
        principal: db.principals[p],
        args: args,
        colors: colors
      }
    });
  });
}



export { initDb, addClaim, getClaims, getFirstCN, getOU }