// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";

abstract contract TERC20ShareBurn {
    /**
     * @dev Role to burn tokens
     */
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /* ============ Events ============ */
    /**
     * @dev Emitted when `value` tokens are burned by transferring them from one account to the address zero
     *
     * Note that `value` may be zero.
     */
    event Burn(address indexed burner, address indexed account, uint256 value);
    /**
     * @dev Emitted when performing burn in batch
     */
    event BatchBurn(
        address indexed burner,
        address[] accounts,
        uint256[] values
    );
    /**
     * @dev Emitted when performing burn in batch with a single value
     */
    event BatchBurnSameValue(
        address indexed burner,
        address[] accounts,
        uint256 value
    );

    /* ============ Errors ============ */
    /**
     * @dev Indicates that the parameter `accounts` is empty.
     * Used with {batchBurn}.
     */
    error Burn_EmptyAccounts();
    /**
     * @dev Indicates that the parameters `accounts` and values don't have the same length
     * Used with {batchBurn}.
     */
    error Burn_AccountsValueslengthMismatch();

    /* ============ Functions ============ */
    /**
     * @notice Destroys a `value` amount of tokens from `account`, by transferring it to address(0).
     * @dev
     * Emits a {Burn} event
     * Emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Requirements:
     * - the caller must have the `BURNER_ROLE`.
     */
    function burn(address account, uint256 value) public virtual;
    /**
     *
     * @notice batch version of {burn}.
     * @dev
     *
     * For each burn action, emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Emits a {BurnBatch} event
     * Requirements:
     * - `accounts` cannot be empty (error Burn_EmptyAccounts)
     * - `accounts` and `values` must have the same length
     * - the caller must have the `BURNER_ROLE`.
     */
    function batchBurn(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;

    /**
     *
     * @notice batch version of {burn} with the same `value` amount of tokens burnt for each account
     * @dev
     *
     * For each burn action, emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Emits a {BatchBurn} event
     * Requirements:
     * - `accounts` cannot be empty (error Burn_EmptyAccounts)
     * - the caller must have the `BURNER_ROLE`.
     */
    function batchBurnSameValue(
        address[] calldata accounts,
        uint256 value
    ) public virtual;
}
