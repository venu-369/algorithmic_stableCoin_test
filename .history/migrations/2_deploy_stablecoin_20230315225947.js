const BasicStablecoin = artifacts.require("BasicStablecoin");

module.exports = function (deployer) {
  deployer.deploy(BasicStablecoin, 100000000000000, 100000000000000);
};
