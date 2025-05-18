// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract LogicV1 {
    uint256 public counter;

    function increment() public {
        counter += 1;
    }

    function getCounter() public view returns (uint256) {
        return counter;
    }
}
