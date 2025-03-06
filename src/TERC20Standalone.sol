// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZ/token/ERC20/ERC20.sol";
import "OZ/access/AccessControl.sol";
import "./lib/TERC20Share.sol";
import "./lib/standalone/TERC20StandaloneBurn.sol";
import "./lib/standalone/TERC20StandaloneMint.sol";
/**
 * @title TERC20 for an immutable deployment, without proxy
 */
contract TERC20Standalone is
    ERC20,
    AccessControl,
    TERC20Share,
    TERC20StandaloneBurn,
    TERC20StandaloneMint
{
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
