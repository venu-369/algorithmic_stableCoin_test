const AlgorithmicStablecoin = artifacts.require("AlgorithmicStablecoin");

module.exports = function (deployer, network, accounts) {
  const initialSupply = 1000000 * 10 ** 18; // Set initial supply, e.g., 1,000,000 tokens
  const aggregatorAddress = "0x..."; // Replace with the price feed aggregator address

  deployer.deploy(AlgorithmicStablecoin, initialSupply, aggregatorAddress);
};
