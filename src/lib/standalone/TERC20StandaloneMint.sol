// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZ/token/ERC20/ERC20.sol";
import "OZ/access/AccessControl.sol";
import "../TERC20ShareMint.sol";

/**
 * @title TERC20 for mint features
 */
abstract contract TERC20StandaloneMint is
    ERC20,
    AccessControl,
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
