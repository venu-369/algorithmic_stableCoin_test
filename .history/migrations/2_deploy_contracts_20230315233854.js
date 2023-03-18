const MockPriceFeed = artifacts.require("MockPriceFeed");
const BasicStablecoin = artifacts.require("BasicStablecoin");

module.exports = async function (deployer) {
  const initialPrice = 200000000; // Replace with the initial price you want to set (8 decimals)
  await deployer.deploy(MockPriceFeed, initialPrice);
  const mockPriceFeed = await MockPriceFeed.deployed();

  await deployer.deploy(BasicStablecoin, mockPriceFeed.address);
};
