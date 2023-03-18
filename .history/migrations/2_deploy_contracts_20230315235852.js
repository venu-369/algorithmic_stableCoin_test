const AlgorithmicStablecoin = artifacts.require("AlgorithmicStablecoin");
const MockPriceFeed = artifacts.require("MockPriceFeed");

module.exports = async function (deployer, network, accounts) {
  // Deploy AlgorithmicStablecoin
  const initialSupply = web3.utils.toWei("1000000", "ether"); // Set the initial supply to 1,000,000 tokens
  const owner = accounts[0]; // Set the owner as the first account provided by Ganache
  await deployer.deploy(AlgorithmicStablecoin, initialSupply, owner);

  // Deploy MockPriceFeed
  const initialPrice = 200000000; // Replace with the initial price you want to set (8 decimals)
  await deployer.deploy(MockPriceFeed, initialPrice);

  // Set price feed in AlgorithmicStablecoin
  const stablecoinInstance = await AlgorithmicStablecoin.deployed();
  const priceFeedInstance = await MockPriceFeed.deployed();
  await stablecoinInstance.setPriceFeedAddress(priceFeedInstance.address);
};
