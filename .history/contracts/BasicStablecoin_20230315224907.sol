//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BasicStablecoin is ERC20 {
    address public owner;
    uint256 public targetPrice;

    constructor(uint256 initialSupply, uint256 _targetPrice) ERC20("Basic Stablecoin", "BSC") {
        owner = msg.sender;
        targetPrice = _targetPrice;
        _mint(msg.sender, initialSupply);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the contract owner");
        _;
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
}
