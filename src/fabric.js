'use strict'
const fs = require('fs');
const { Wallets, Gateway } = require('fabric-network');
const { X509Certificate } = require('@peculiar/x509');

const walletDirectoryPath = "../H/fabric-samples/asset-transfer-basic/application-java/wallet";
const connectionProfileFileName = "../H/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/connection-org1.json";
const channelName = "mychannel"
const chaincodeId = "basic";
// const userId = "appUser";

async function getUserCertificate(userId) {
  const wallet = await Wallets.newFileSystemWallet(walletDirectoryPath);
  const identity = await wallet.get(userId);
  if (identity && identity.type === 'X.509') {
    return identity.credentials.certificate;
  }
  return null;
}

async function connect(userId) {

  const connectionProfileJson = (await fs.promises.readFile(connectionProfileFileName)).toString();
  const connectionProfile = JSON.parse(connectionProfileJson);
  const wallet = await Wallets.newFileSystemWallet(walletDirectoryPath);

  const gatewayOptions = {
    identity: userId,
    wallet,
    discovery: { enabled: true, asLocalhost: true }
  };
  const gateway = new Gateway();
  await gateway.connect(connectionProfile, gatewayOptions);

  // const pem = gateway.getIdentity().credentials.certificate;
  // console.log(pem);

  const network = await gateway.getNetwork(channelName);
  const contract = network.getContract(chaincodeId);
  return contract
}

// TODO: This listens to all events
async function addContractListener(contract, listener) {
  const l = async (event) => {
    listener(event.payload.toString());
  };
  contract.addContractListener(l);
}

async function log(contract, msg) {
  contract.submitTransaction('Claim', msg);
}

exports.getUserCertificate = getUserCertificate;
exports.connect = connect;
exports.addContractListener = addContractListener;
exports.log = log;