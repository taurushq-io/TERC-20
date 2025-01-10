// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";
abstract contract TERC20Share is IERC20, IAccessControl {
    /** 
    * @notice 
    * Get the current version of the smart contract
    */
    string public constant VERSION = "0.1.0";

    /* ============ Access Control ============ */
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /* ============ Events ============ */
    event Burn(address indexed burner, address indexed account, uint256 value);
    event BurnBatch(
        address indexed burner,
        address[] accounts,
        uint256[] values
    );
    event BurnBatch(address indexed burner, address[] accounts, uint256 value);
    event Mint(address indexed minter, address indexed account, uint256 value);
    event MintBatch(
        address indexed minter,
        address[] accounts,
        uint256[] values
    );
    event MintBatch(address indexed minter, address[] accounts, uint256 value);

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
    function burnBatch(
        address[] calldata accounts,
        uint256 value
    ) public virtual;
    function burn(address account, uint256 value) public virtual;
    function mintBatch(
        address[] calldata accounts,
        uint256[] calldata values
    ) public virtual;
    function mintBatch(
        address[] calldata accounts,
        uint256 value
    ) public virtual;
    function mint(address account, uint256 value) public virtual;
}
