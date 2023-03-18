// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract AlgorithmicStablecoin is ERC20 {
    AggregatorV3Interface internal priceFeed;
    address public owner;

    uint256 public targetPrice = 1 * 10**8; // Target price of 1 USD with 8 decimals
    uint256 public expansionPercentage = 5; // 5% expansion or contraction

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(uint256 initialSupply, address aggregatorAddress)
        ERC20("Algorithmic Stablecoin", "ALGST")
    {
        _mint(msg.sender, initialSupply);
        priceFeed = AggregatorV3Interface(aggregatorAddress);
        owner = msg.sender;
    }

    function getLatestPrice() public view returns (int) {
        (, int price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    function adjustSupply() public onlyOwner {
        int256 currentPrice = getLatestPrice();
        if (currentPrice > int256(targetPrice)) {
            uint256 expansionAmount = (totalSupply() * expansionPercentage) / 100;
            _mint(owner, expansionAmount);
        } else if (currentPrice < int256(targetPrice)) {
            uint256 contractionAmount = (totalSupply() * expansionPercentage) / 100;
            _burn(owner, contractionAmount);
        }
    }
}
