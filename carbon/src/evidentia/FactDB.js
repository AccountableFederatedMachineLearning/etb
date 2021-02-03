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
    db.principals.push(principal)
    id = db.principals.length - 1;
  } 
  return id;
}

function addClaim(db, msg) {
  let cn = getPrincipal(db, msg.principal);
  let claims = db.claims;
  if (claims[msg.literal.symbol] === undefined) {
    claims[msg.literal.symbol] = {};
  }
  if (claims[msg.literal.symbol][cn] === undefined) {
    claims[msg.literal.symbol][cn] = {};
  }
  let args = JSON.stringify(msg.literal.arguments);
  if (claims[msg.literal.symbol][cn][args] === undefined) {
    claims[msg.literal.symbol][cn][args] = new Set();
  }
  claims[msg.literal.symbol][cn][args].add(msg.color);
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