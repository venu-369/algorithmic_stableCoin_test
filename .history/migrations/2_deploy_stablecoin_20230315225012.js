const BasicStablecoin = artifacts.require("BasicStablecoin");

module.exports = function (deployer) {
  deployer.deploy(BasicStablecoin, 1000000000000000000000, 1000000000000000000);
};
