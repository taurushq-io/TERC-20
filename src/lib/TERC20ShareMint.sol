// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";

abstract contract TERC20ShareMint {
    /* ============ Access Control ============ */
    /**
     * @dev Role to mint tokens
     */
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /* ============ Events ============ */
    /**
     * @dev Emitted when `value` tokens are minted by transferring them from the address zero to the account to
     *
     * Note that `value` may be zero.
     */
    event Mint(address indexed minter, address indexed account, uint256 value);
    /**
     * @dev Emitted when performing mint in batch with one specific value by account
     */
    event BatchMint(
        address indexed minter,
        address[] accounts,
        uint256[] values
    );
    /**
     * @dev Emitted when performing mint in batch with the same value
     */
    event BatchMintSameValue(
        address indexed minter,
        address[] accounts,
        uint256 value
    );

    /* ============ Errors ============ */
    /**
     * @dev Indicates that the parameter `accounts` is empty.
     * Used with {batchMint}.
     */
    error Mint_EmptyAccounts();
    /**
     * @dev Indicates that the parameters `accounts` and values don't have the same length
     * Used with {batchMint}.
     */
    error Mint_AccountsValueslengthMismatch();

    /* ============ Functions ============ */
    /**
     * @notice  Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0)
     * @param account token receiver
     * @param value amount of tokens
     * @dev
     * See {OpenZeppelin ERC20-_mint}.
     * Emits a {Mint} event.
     * Emits a {Transfer} event with `from` set to the zero address (emits inside _mint).
     *
     * Requirements:
     * - `account` cannot be the zero address (check made by _mint, error ERC20InvalidReceiver).
     * - The caller must have the `MINTER_ROLE`.
     */
    function mint(address account, uint256 value) public virtual;

    /**
     *
     * @notice batch version of {mint}
     * @dev
     *
     * For each mint action, emits a {Transfer} event with `from` set to the zero address (emits inside _mint).
     * Emits a {BatchMint} event.
     * Requirements:
     * - `accounts` cannot be empty (error Mint_EmptyAccounts)
     * - `accounts` and `values` must have the same length (error Mint_AccountsValueslengthMismatch)
     * - `accounts` cannot contain a zero address (check made by _mint, error ERC20InvalidReceiver).
     * - the caller must have the `MINTER_ROLE` (error AccessControlUnauthorizedAccount).
     */
    function batchMint(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;

    /**
     *
     * @notice batch version of {mint} with the same `value` amount of tokens minted for each account
     * @dev
     *
     * For each mint action, emits a {Transfer} event with `from` set to the zero address (emits inside _mint).
     * Emits a {BatchMintSameValue} event.
     * Requirements:
     * - `accounts` cannot be empty (error Mint_EmptyAccounts)
     * - `accounts` cannot contain a zero address (check made by _mint, error ERC20InvalidReceiver).
     * -  the caller must have the `MINTER_ROLE` (error AccessControlUnauthorizedAccount)
     */
    function batchMintSameValue(
        address[] calldata accounts,
        uint256 value
    ) public virtual;
}
