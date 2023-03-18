const BasicStablecoin = artifacts.require("BasicStablecoin");

module.exports = function (deployer) {
  const priceFeed = 0x72afaecf99c9d9c8215ff44c77b94b99c28741e8; // Replace with the actual address
  deployer.deploy(
    BasicStablecoin,
    1000000000000000,
    1000000000000000,
    priceFeed
  );
};
