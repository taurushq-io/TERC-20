// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZ/token/ERC20/ERC20.sol";
import "OZ/access/AccessControl.sol";
import "../TERC20ShareBurn.sol";

/**
 * @title TERC20 for burn features
 */
abstract contract TERC20StandaloneBurn is
    ERC20,
    AccessControl,
    TERC20ShareBurn
{
    /**
     * @inheritdoc TERC20ShareBurn
     */
    function burn(
        address account,
        uint256 value
    ) public virtual override onlyRole(BURNER_ROLE) {
        _burn(account, value);
        emit Burn(msg.sender, account, value);
    }

    /**
     * @inheritdoc TERC20ShareBurn
     */
    function batchBurn(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual override onlyRole(BURNER_ROLE) {
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

    /**
     * @inheritdoc TERC20ShareBurn
     */
    function batchBurnSameValue(
        address[] calldata accounts,
        uint256 value
    ) public virtual override onlyRole(BURNER_ROLE) {
        require(accounts.length != 0, Burn_EmptyAccounts());
        for (uint256 i = 0; i < accounts.length; ++i) {
            _burn(accounts[i], value);
        }
        emit BatchBurnSameValue(msg.sender, accounts, value);
    }
}
