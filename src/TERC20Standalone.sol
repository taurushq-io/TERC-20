// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZ/token/ERC20/ERC20.sol";
import "OZ/access/AccessControl.sol";
import "./lib/TERC20Share.sol";

contract TERC20Standalone is ERC20, AccessControl, TERC20Share {
    uint8 internal immutable _decimals;

    constructor(
        address admin,
        string memory name,
        string memory symbol,
        uint8 decimals_
    ) ERC20(name, symbol) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _decimals = decimals_;
    }

    /* ============ Decimals ============ */

    /**
     *
     * @notice Returns the number of decimals used to get its user representation.
     * @inheritdoc ERC20
     */
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    /* ============ Mint ============ */
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
    function mint(
        address account,
        uint256 value
    ) public override onlyRole(MINTER_ROLE) {
        _mint(account, value);
        emit Mint(msg.sender, account, value);
    }

    /**
     *
     * @notice batch version of {mint}
     * @dev
     * Emits a {MintBatch} event.
     * Requirements:
     * - `accounts` cannot be empty
     * - `accounts` and `values` must have the same length
     * - `accounts` cannot contain a zero address (check made by _mint).
     * - the caller must have the `MINTER_ROLE`.
     */
    function mintBatch(
        address[] calldata accounts,
        uint256[] calldata values
    ) public override onlyRole(MINTER_ROLE) {
        require(accounts.length != 0, Mint_EmptyAccounts());
        // We do not check that values is not empty since
        // this require will throw an error in this case.
        require(
            accounts.length == values.length,
            Mint_AccountsValueslengthMismatch()
        );
        for (uint256 i = 0; i < accounts.length; ++i) {
            _mint(accounts[i], values[i]);
        }
        emit MintBatch(msg.sender, accounts, values);
    }

    /**
     *
     * @notice batch version of {mint}
     * @dev
     * Emits a {MintBatch} event.
     * Requirements:
     * - `accounts` cannot be empty
     * - `accounts` cannot contain a zero address (check made by _mint).
     * - the caller must have the `MINTER_ROLE`.
     */
    function mintBatch(
        address[] calldata accounts,
        uint256 value
    ) public override onlyRole(MINTER_ROLE) {
        require(accounts.length != 0, Mint_EmptyAccounts());
        for (uint256 i = 0; i < accounts.length; ++i) {
            _mint(accounts[i], value);
        }
        emit MintBatch(msg.sender, accounts, value);
    }

    /* ============ Burn ============ */

    /**
     * @notice Destroys a `value` amount of tokens from `account`, by transferring it to address(0).
     * @param account token holder
     * @param value amount of tokens to burn
     * @dev
     * See {ERC20-_burn}
     * Emits a {Burn} event
     * Emits a {Transfer} event with `to` set to the zero address  (emits inside _burn).
     * Requirements:
     * - the caller must have the `BURNER_ROLE`.
     */
    function burn(
        address account,
        uint256 value
    ) public override onlyRole(BURNER_ROLE) {
        _burn(account, value);
        emit Burn(msg.sender, account, value);
    }

    /**
     *
     * @notice batch version of {burn}.
     * @dev
     * Emits a {BurnBatch} event
     * Requirements:
     * - `accounts` cannot be empty
     * - `accounts` and `values` must have the same length
     * - the caller must have the `BURNER_ROLE`.
     */
    function burnBatch(
        address[] calldata accounts,
        uint256[] calldata values
    ) public override onlyRole(BURNER_ROLE) {
        require(accounts.length != 0, Burn_EmptyAccounts());
        // We do not check that values is not empty since
        // this require will throw an error in this case.
        require(
            accounts.length == values.length,
            Burn_AccountsValueslengthMismatch()
        );
        for (uint256 i = 0; i < accounts.length; ++i) {
            _burn(accounts[i], values[i]);
        }
        emit BurnBatch(msg.sender, accounts, values);
    }

    /**
     *
     * @notice batch version of {burn}.
     * @dev
     * Emits a {BurnBatch} event
     * Requirements:
     * - `accounts` cannot be empty
     * - `accounts` and `values` must have the same length
     * - the caller must have the `BURNER_ROLE`.
     */
    function burnBatch(
        address[] calldata accounts,
        uint256 value
    ) public override onlyRole(BURNER_ROLE) {
        require(accounts.length != 0, Burn_EmptyAccounts());
        for (uint256 i = 0; i < accounts.length; ++i) {
            _burn(accounts[i], value);
        }
        emit BurnBatch(msg.sender, accounts, value);
    }

    /* ============ ACCESS CONTROL ============ */
    /**
     * @notice Returns `true` if `account` has been granted `role`.
     */
    function hasRole(
        bytes32 role,
        address account
    )
        public
        view
        virtual
        override(AccessControl, IAccessControl)
        returns (bool)
    {
        // The Default Admin has all roles
        if (AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        }
        return AccessControl.hasRole(role, account);
    }
}
