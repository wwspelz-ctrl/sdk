// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import {IZKVerifier} from "./interfaces/IZKVerifier.sol";

/// @notice Minimal swap router skeleton.
/// @dev This is intentionally a *non-custodial* example skeleton without any anonymity features.
contract VeilSwapRouter is ReentrancyGuard {
    using SafeERC20 for IERC20;

    event SwapExecuted(address indexed user, address indexed tokenIn, address indexed tokenOut, uint256 amountIn);

    IZKVerifier public verifier; // optional hook

    constructor(IZKVerifier _verifier) {
        verifier = _verifier;
    }

    /// @notice Example hook: verify a proof that user satisfies a condition (e.g. "not on a denylist") without revealing details.
    function _optionalVerify(bytes calldata proof, bytes32[] calldata publicInputs) internal view {
        if (address(verifier) == address(0)) return;
        require(verifier.verifyProof(proof, publicInputs), "INVALID_PROOF");
    }

    /// @notice Example “swap” placeholder. Replace with real AMM integration (e.g., UniswapV2/V3).
    /// @dev This function just transfers tokenIn to this contract and emits an event.
    function swapExactTokensForTokens(
        IERC20 tokenIn,
        IERC20 tokenOut,
        uint256 amountIn,
        bytes calldata zkProof,
        bytes32[] calldata zkPublicInputs
    ) external nonReentrant {
        require(amountIn > 0, "AMOUNT_IN_ZERO");

        _optionalVerify(zkProof, zkPublicInputs);

        tokenIn.safeTransferFrom(msg.sender, address(this), amountIn);

        // Placeholder: no pricing, no pool interaction. This is a scaffold only.
        // tokenOut.safeTransfer(msg.sender, amountOut);

        emit SwapExecuted(msg.sender, address(tokenIn), address(tokenOut), amountIn);
    }
}
