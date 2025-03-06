// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "OZ/token/ERC20/IERC20.sol";
import "OZ/access/IAccessControl.sol";
import "./TERC20ShareBurn.sol";
import "./TERC20ShareMint.sol";

/**
 * @dev Contract defining the common features of a TERC20
 */
abstract contract TERC20Share is
    IERC20,
    IAccessControl,
    TERC20ShareMint,
    TERC20ShareBurn
{
    /**
     * @notice
     * Get the current version of the smart contract
     */
    string internal constant VERSION = "1.0.0";

    /**
     * @notice Return current contract version
     */
    function version() public view virtual returns (string memory);
}
