'use strict'
const config = require('./config')
const fs = require('fs')
const { Wallets, Gateway } = require('fabric-network')

async function readWallet() {
  var wallet;
  try {
    wallet = await Wallets.newFileSystemWallet(config.walletDirectory);
  } catch (e) {
    throw ("Cannot read wallet from directory " + config.walletDirectory +
      "\n" + e +
      "\nCheck walletDirectory setting in config.js.");
  }
  return wallet;
}

async function readConnectionProfile() {
  var profile;
  try {
    const profileJson = (await fs.promises.readFile(config.connectionProfile)).toString();
    profile = JSON.parse(profileJson);
  } catch (e) {
    throw ("Cannot read connection profile from " + config.connectionProfile +
      "\n" + e +
      "\nCheck walletDirectory setting in config.js.");
  }
  return profile;
}


async function getUserCertificate(userId) {
  const wallet = await readWallet();
  const identity = await wallet.get(userId);
  if (!identity) {
    throw "Cannot find user '" + userId + "' in wallet."
  }
  if (identity.type !== 'X.509') {
    throw "User certificate not in X.509 format."
  }
  return identity.credentials.certificate;
}

async function connect(userId) {

  const connectionProfile = await readConnectionProfile();
  const wallet = await readWallet();

  const gatewayOptions = {
    identity: userId,
    wallet,
    discovery: { enabled: true, asLocalhost: true }
  };
  const gateway = new Gateway();
  await gateway.connect(connectionProfile, gatewayOptions);

  const network = await gateway.getNetwork(config.channelName);
  const contract = network.getContract(config.chaincodeId);
  return contract
}

// TODO: This listens to all events
async function addContractListener(contract, listener) {
  const l = async (event) => {
    const transactionEvent = event.getTransactionEvent();
    if (transactionEvent.isValid) {
      listener(event.payload.toString(), transactionEvent.transactionId);
    }
  };
  contract.addContractListener(l);
}

async function addClaim(contract, msg) {
  contract.submitTransaction('Claim', msg).catch(e => {
    console.log("Error submitting transaction. Trying again later.");
    setTimeout(function(){
      addClaim(contract, msg);
    }, 5000*(1 + Math.random()));
  });
}

exports.getUserCertificate = getUserCertificate;
exports.connect = connect;
exports.addContractListener = addContractListener;
exports.addClaim = addClaim;