// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZUpgradeable/token/ERC20/ERC20Upgradeable.sol";
import "OZUpgradeable/access/AccessControlUpgradeable.sol";
import "OZUpgradeable/proxy/utils/Initializable.sol";
import "../TERC20ShareMint.sol";

/**
 * @title TERC20Upgradeable for mint features
 */
abstract contract TERC20UpgradeableMint is
    ERC20Upgradeable,
    AccessControlUpgradeable,
    TERC20ShareMint
{
    /**
     * @inheritdoc TERC20ShareMint
     */
    function mint(
        address account,
        uint256 value
    ) public virtual override onlyRole(MINTER_ROLE) {
        _mint(account, value);
        emit Mint(msg.sender, account, value);
    }

    /**
     * @inheritdoc TERC20ShareMint
     */
    function batchMint(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual override onlyRole(MINTER_ROLE) {
        if (accounts.length == 0) {
            revert Mint_EmptyAccounts();
        }
        // We do not check that values is not empty since
        // this require will throw an error in this case.
        if (bool(accounts.length != values.length)) {
            revert Mint_AccountsValueslengthMismatch();
        }
        for (uint256 i = 0; i < accounts.length; ++i) {
            _mint(accounts[i], values[i]);
        }
        emit BatchMint(msg.sender, accounts, values);
    }

    /**
     * @inheritdoc TERC20ShareMint
     */
    function batchMintSameValue(
        address[] calldata accounts,
        uint256 value
    ) public virtual override onlyRole(MINTER_ROLE) {
        require(accounts.length != 0, Mint_EmptyAccounts());
        for (uint256 i = 0; i < accounts.length; ++i) {
            _mint(accounts[i], value);
        }
        emit BatchMintSameValue(msg.sender, accounts, value);
    }
}
