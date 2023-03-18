// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract BasicStablecoin is ERC20 {
    address public owner;
    uint256 public targetPrice;
    uint8 public priceFeedDecimals;
    AggregatorV3Interface internal priceFeed;

    constructor(
        uint256 initialSupply,
        uint256 _targetPrice,
        address _priceFeed
    ) ERC20("Basic Stablecoin", "BSC") {
        owner = msg.sender;
        targetPrice = _targetPrice;
        priceFeed = AggregatorV3Interface(_priceFeed);
        _mint(msg.sender, initialSupply);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function setPriceFeedDecimals() public onlyOwner {
        try priceFeed.decimals() returns (uint8 decimals) {
            priceFeedDecimals = decimals;
        } catch {
            revert("Error fetching decimals from price feed");
        }
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner {
        _burn(from, amount);
    }

    function setTargetPrice(uint256 newPrice) public onlyOwner {
        targetPrice = newPrice;
    }

    function getLatestPrice() public view returns (int256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    function getPriceFeedDecimals() public view returns (uint8) {
        return priceFeedDecimals;
    }

    function adjustSupply() public onlyOwner {
        int256 currentPrice = getLatestPrice();

        if (currentPrice > int256(targetPrice)) {
            uint256 amountToMint = (uint256(currentPrice) - targetPrice) / targetPrice;
            _mint(owner, amountToMint);
        } else if (currentPrice < int256(targetPrice)) {
            uint256 amountToBurn = (targetPrice - uint256(currentPrice)) / targetPrice;
            _burn(owner, amountToBurn);
        }
    }
}
