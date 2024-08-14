// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ERC20FlashMint.sol";

contract ShefToken is ERC20, ERC20FlashMint {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() ERC20("ShefToken", "SHEF") {
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to, amount);
    }

    function _flashFee(address, uint256  value) internal pure override returns(uint256){
        return value/1000;
    }

    function _flashFeeRecevier() internal view override returns(address){
        return owner;
    }
}
