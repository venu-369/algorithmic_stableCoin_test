// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract BasicStablecoin is ERC20 {
    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress)
        ERC20("Basic Stablecoin", "BSC")
    {
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function getPriceFeedDecimals() public view returns (uint8) {
        return priceFeed.decimals();
    }

    function getLatestPrice() public view returns (int256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return price;
    }
}
