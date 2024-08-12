// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC3156FlashLender} from "./IERC3156FlashLender.sol";
import {IERC3156FlashBorrower} from "./IERC3156FlashBorrower.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract ERC20FlashMint is ERC20, IERC3156FlashLender {
    bytes32 private constant RETURN_VALUE =
        keccak256("ERC3156FlashBorrower.onFlashLoan");

    error ERC3156UnsupportedToken(address token);
    error ERC3156ExceededMaxLoan(uint maxLoan);
    error ERC3156InvalidReceiver(address receiver);

    function maxFlashLoan(address token) public view virtual returns (uint256) {
        return token == address(this) ? type(uint256).max - totalSupply() : 0;
    }

    function flashFee(
        address token,
        uint256 value
    ) public view virtual returns (uint256) {
        if (token != address(this)) {
            revert ERC3156UnsupportedToken(token);
        }

        return _flashFee(token, value);
    }

    function flashLoan(
        IERC3156FlashBorrower receiver,
        address token,
        uint256 value,
        bytes calldata data
    ) public returns (bool) {
        uint256 maxLoan = maxFlashLoan(token);

        if (value > maxLoan) {
            revert ERC3156ExceededMaxLoan(maxLoan);
        }

        uint256 fee = flashFee(token, value);

        _mint(address(receiver), value);

        if (
            receiver.onFlashLoan(_msgSender(), token, value, fee, data) !=
            RETURN_VALUE
        ) {
            revert ERC3156InvalidReceiver(address(receiver));
        }

        address flashFeeRecevier = _flashFeeRecevier();

        _spendAllowance(address(receiver), address(this), value + fee);

        if (fee == 0 || flashFeeRecevier == address(0)) {
            _burn(address(receiver), value + fee);
        } else {
            _burn(address(receiver), value + fee);
            _transfer(address(receiver), flashFeeRecevier, fee);
        }

        return true;
    }

    function _flashFee(
        address token,
        uint256 value
    ) internal view virtual returns (uint256) {
        return 0;
    }

    function _flashFeeRecevier() internal view virtual returns (address) {
        return address(0);
    }
}
