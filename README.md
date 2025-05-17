# Upgradeable Smart Contract - EIP-1967 Proxy Pattern

## Overview

This repository demonstrates a simplified implementation of the **EIP-1967 proxy standard** using Solidity. Proxy contracts are essential for enabling upgradability in smart contracts by separating the storage and logic layers.

## What is EIP-1967?

EIP-1967 defines a standard for locating the implementation address of a proxy contract using specific storage slots. It was designed to avoid conflicts with the logic contract's state variables and simplify contract upgrades.

The pattern uses **delegatecall** to forward calls from the proxy to the logic (implementation) contract. This allows the proxy to maintain the state while the logic can be changed by deploying a new implementation.

### Key Features

- Storage slot for implementation: `bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)`
- Avoids collision with logic contract's storage layout.
- Secure and predictable upgrade mechanism.

## Why Use Proxy Contracts?

Smart contracts on Ethereum are immutable once deployed. To introduce new features, fix bugs, or improve gas efficiency, developers use **proxy patterns** to upgrade the logic while keeping the contract's state intact.

## How EIP-1967 Works

- The **proxy contract** holds all the storage.
- The **implementation contract** contains the logic.
- Calls to the proxy are delegated to the implementation using `delegatecall`.
- Upgrading involves updating the implementation address stored in a special slot.

## Pros

- Upgradeable logic without losing contract state.
- Widely used and supported by tools like OpenZeppelin.
- Avoids storage collision issues.

## Cons

- Slightly more complex to set up and test.
- Delegated calls can be less readable.
- Improperly secured upgrade functions can be exploited.

## Resources

- [EIP-1967 Specification](https://eips.ethereum.org/EIPS/eip-1967)
- [OpenZeppelin Upgrades Guide](https://docs.openzeppelin.com/upgrades/2.3/)
- [Solidity Documentation](https://docs.soliditylang.org/en/v0.8.19/)

## Structure

- `Proxy.sol`: The minimal proxy contract implementing EIP-1967.
- `LogicV1.sol`: The first version of the logic contract.
- `LogicV2.sol`: An upgraded version with additional functionality.

