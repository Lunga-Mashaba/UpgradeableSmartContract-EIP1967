// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract LogicV2 {
    uint256 public counter;

    function increment() public {
        counter += 2;
    }

    function reset() public {
        counter = 0;
    }

    function getCounter() public view returns (uint256) {
        return counter;
    }
}
