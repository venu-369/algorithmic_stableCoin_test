const BasicStablecoin = artifacts.require("BasicStablecoin");

const BasicStablecoin = artifacts.require("BasicStablecoin");
const MockPriceFeed = artifacts.require("MockPriceFeed");

module.exports = async function (deployer) {
  const priceFeedInstance = await MockPriceFeed.deployed();
  const priceFeedAddress = priceFeedInstance.address;

  deployer.deploy(
    BasicStablecoin,
    "100000000000000000000",
    "1000000000000000000",
    priceFeedAddress
  );
};
