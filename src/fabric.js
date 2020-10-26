'use strict'
const fs = require('fs');
const path = require('path');
const { Wallets, Gateway } = require('fabric-network');

const walletDirectoryPath = "../H/fabric-samples/asset-transfer-basic/application-java/wallet";
const connectionProfileFileName = "../H/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/connection-org1.json";
const channelName = "mychannel"
const chaincodeId = "basic";

async function connect() {

  const connectionProfileJson = (await fs.promises.readFile(connectionProfileFileName)).toString();
  const connectionProfile = JSON.parse(connectionProfileJson);
  const wallet = await Wallets.newFileSystemWallet(walletDirectoryPath);

  const gatewayOptions = {
    identity: 'appUser',
    wallet,
    discovery: { enabled: true, asLocalhost: true }
  };
  const gateway = new Gateway();
  await gateway.connect(connectionProfile, gatewayOptions);

  const network = await gateway.getNetwork(channelName);
  const contract = network.getContract(chaincodeId);
  return contract
}

async function addContractListener(contract, listener) {
  const l = async (event) => {
    listener(event.payload.toString());
  };
  contract.addContractListener(l);
}

async function log(contract, msg) {
  contract.submitTransaction('AddLog', msg);
}

exports.connect = connect;
exports.addContractListener = addContractListener;
exports.log = log;