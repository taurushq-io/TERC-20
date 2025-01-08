// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";
abstract contract TERC20Share is IERC20, IAccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /* ============ Events ============ */
    event Burn(address indexed burner, address indexed account, uint256 value);
    event BurnBatch(
        address indexed burner,
        address[] accounts,
        uint256[] values
    );
    event Mint(address indexed minter, address indexed account, uint256 value);
    event MintBatch(
        address indexed minter,
        address[] accounts,
        uint256[] values
    );

    /* ============ Errors ============ */
    error Burn_EmptyAccounts();
    error Burn_AccountsValueslengthMismatch();
    error Mint_EmptyAccounts();
    error Mint_AccountsValueslengthMismatch();

    /* ============ Functions ============ */
    function burnBatch(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;
    function burn(address account, uint256 value) public virtual;
    function mintBatch(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;
    function mint(address account, uint256 value) public virtual;
}
