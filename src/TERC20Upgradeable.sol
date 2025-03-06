// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "OZUpgradeable/token/ERC20/ERC20Upgradeable.sol";
import "OZUpgradeable/access/AccessControlUpgradeable.sol";
import "OZUpgradeable/proxy/utils/Initializable.sol";
import "./lib/TERC20Share.sol";
import "./lib/upgradeable/TERC20UpgradeableBurn.sol";
import "./lib/upgradeable/TERC20UpgradeableMint.sol";
/**
 * @title TERC20 for an upgradeable deployment, with a compatible proxy (Transparent or Beacon)
 */
contract TERC20Upgradeable is
    Initializable,
    ERC20Upgradeable,
    AccessControlUpgradeable,
    TERC20Share,
    TERC20UpgradeableBurn,
    TERC20UpgradeableMint
{
    /* ============ ERC-7201 ============ */
    // keccak256(abi.encode(uint256(keccak256("TERC20Upgradeable.storage.main")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant TERC20UpgradeableStorageLocation =
        0x62374c23c8c0cceb4a052e57aab238a6e83d4a9ccfdde2e23a90e09ce863f000;
    /* ==== ERC-7201 State Variables === */
    struct TERC20UpgradeableStorage {
        uint8 _decimals;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        address admin,
        string memory name,
        string memory symbol,
        uint8 decimals_
    ) public initializer {
        /* OpenZeppelin library */
        // OZ init_unchained functions are called firstly due to inheritance
        __Context_init_unchained();
        __ERC20_init_unchained(name, symbol);
        // AccessControlUpgradeable inherits from ERC165Upgradeable
        __ERC165_init_unchained();
        __AccessControl_init_unchained();
        __TERC20Upgradeable_init_unchained(admin, decimals_);
    }
    function __TERC20Upgradeable_init_unchained(
        address admin,
        uint8 decimals_
    ) internal onlyInitializing {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        TERC20UpgradeableStorage storage $ = _getTERC20UpgradeableStorage();
        $._decimals = decimals_;
    }

    /*//////////////////////////////////////////////////////////////
                            PUBLIC/EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /* ============ Decimals ============ */
    /**
     *
     * @notice Returns the number of decimals used to get its user representation.
     * @inheritdoc ERC20Upgradeable
     */
    function decimals()
        public
        view
        virtual
        override(ERC20Upgradeable)
        returns (uint8)
    {
        TERC20UpgradeableStorage storage $ = _getTERC20UpgradeableStorage();
        return $._decimals;
    }

    /**
     * @inheritdoc TERC20Share
     */
    function version()
        public
        pure
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
        override(AccessControlUpgradeable, IAccessControl)
        returns (bool)
    {
        // The Default Admin has all roles
        if (AccessControlUpgradeable.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        }
        return AccessControlUpgradeable.hasRole(role, account);
    }

    /*//////////////////////////////////////////////////////////////
                            INTERNAL/PRIVATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /* ============ ERC-7201 ============ */
    function _getTERC20UpgradeableStorage()
        private
        pure
        returns (TERC20UpgradeableStorage storage $)
    {
        assembly {
            $.slot := TERC20UpgradeableStorageLocation
        }
    }
}
