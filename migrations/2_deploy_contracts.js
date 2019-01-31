var LivePod_Token = artifacts.require("./livepod_token.sol");

module.exports = function(deployer) {
  deployer.deploy(LivePod_Token, 300000000);
};
