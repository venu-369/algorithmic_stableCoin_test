const BasicStablecoin = artifacts.require("BasicStablecoin");

module.exports = function (deployer) {
  deployer.deploy(BasicStablecoin, 10000000000000000000, 10000000000000000);
};
