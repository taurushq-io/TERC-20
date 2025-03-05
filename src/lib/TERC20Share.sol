// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";

/**
* @dev Contract defining the common features of a TERC20
*/
abstract contract TERC20Share is IERC20, IAccessControl {
    /**
     * @notice
     * Get the current version of the smart contract
     */
    string internal constant VERSION = "1.0.0";
    /**
     * @dev Role to mint tokens
     */
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
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
     * @dev Emitted when `value` tokens are minted by transferring them from the address zero to the account to
     *
     * Note that `value` may be zero.
     */
    event Mint(address indexed minter, address indexed account, uint256 value);
    /**
     * @dev Emitted when performing mint in batch
     */
    event BatchMint(
        address indexed minter,
        address[] accounts,
        uint256[] values
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
     * @notice Destroys a `value` amount of tokens from `account`, by transferring it to address(0).
     * @dev
     * See {ERC20-_burn}
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
     * See {ERC20-_burn}.
     *
     * For each burn action, emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Emits a {BurnBatch} event
     * The burn `reason`is the same for all `accounts` which tokens are burnt.
     * Requirements:
     * - `accounts` and `values` must have the same length
     * - the caller must have the `BURNER_ROLE`.
     */
    function batchBurn(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;

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
     * - `account` cannot be the zero address (check made by _mint).
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
     * - `accounts` and `values` must have the same length
     * - `accounts` cannot contain a zero address (check made by _mint).
     * - the caller must have the `MINTER_ROLE`.
     */
    function batchMint(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;

    /**
    * @notice Return current contract version
    */
    function version() public view virtual returns (string memory);
}
