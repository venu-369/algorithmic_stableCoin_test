const MockPriceFeed = artifacts.require("MockPriceFeed");

module.exports = function (deployer) {
  const initialPrice = 200000000; // Replace with the initial price you want to set (8 decimals)
  deployer.deploy(MockPriceFeed, initialPrice);
};
