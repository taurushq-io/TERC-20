// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZ/token/ERC20/ERC20.sol";
import "OZ/access/AccessControl.sol";
import "./lib/TERC20Share.sol";

/**
* @title TERC20 for an immutable deployment, without proxy
*/
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
    function decimals() public view virtual override(ERC20) returns (uint8) {
        return _decimals;
    }

    /**
    * @inheritdoc TERC20Share
    */
    function version()
        public
        pure
        virtual
        override(TERC20Share)
        returns (string memory)
    {
        return TERC20Share.VERSION;
    }

    /* ============ Mint ============ */
    /**
    * @inheritdoc TERC20Share
    */
    function mint(
        address account,
        uint256 value
    ) public override onlyRole(MINTER_ROLE) {
        _mint(account, value);
        emit Mint(msg.sender, account, value);
    }

    /**
    * @inheritdoc TERC20Share
    */
    function batchMint(
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
        emit BatchMint(msg.sender, accounts, values);
    }

    /* ============ Burn ============ */

    /**
    * @inheritdoc TERC20Share
    */
    function burn(
        address account,
        uint256 value
    ) public override onlyRole(BURNER_ROLE) {
        _burn(account, value);
        emit Burn(msg.sender, account, value);
    }

    /**
    * @inheritdoc TERC20Share
    */
    function batchBurn(
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
        emit BatchBurn(msg.sender, accounts, values);
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
