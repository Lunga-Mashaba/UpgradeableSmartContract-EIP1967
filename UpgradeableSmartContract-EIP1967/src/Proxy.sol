
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Proxy
 * @dev A simplified implementation of the EIP-1967 proxy pattern.
 *      It delegates calls to an implementation contract using delegatecall,
 *      and stores the implementation address at a specific storage slot to avoid collisions.
 */
contract Proxy {
    // keccak256("eip1967.proxy.implementation") - 1
    // = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    bytes32 private constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    /**
     * @dev Sets the initial implementation address.
     */
    constructor(address _implementation) {
        setImplementation(_implementation);
    }

    /**
     * @dev Sets a new implementation address in the defined storage slot.
     */
    function setImplementation(address _newImplementation) public {
        require(_newImplementation != address(0), "Invalid implementation address");

        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            sstore(slot, _newImplementation)
        }
    }

    /**
     * @dev Returns the current implementation address.
     */
    function getImplementation() public view returns (address impl) {
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            impl := sload(slot)
        }
    }

    /**
     * @dev Delegates the call to the implementation.
     */
    fallback() external payable {
        address impl = getImplementation();
        require(impl != address(0), "Implementation not set");

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    /**
     * @dev Allows the proxy to receive Ether.
     */
    receive() external payable {}
}