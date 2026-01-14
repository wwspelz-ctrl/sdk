// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Minimal interface for a ZK proof verifier contract.
/// @dev Replace with the generated verifier from your chosen ZK system.
interface IZKVerifier {
    function verifyProof(bytes calldata proof, bytes32[] calldata publicInputs) external view returns (bool);
}
