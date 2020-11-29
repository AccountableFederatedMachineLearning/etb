'use strict'

var config = {};
config.connectionProfile = "../H/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/connection-org1.json";
config.channelName = "mychannel";
config.chaincodeId = "basic";
config.walletDirectory = "../H/fabric-samples/asset-transfer-basic/application-java/wallet";

module.exports = config;