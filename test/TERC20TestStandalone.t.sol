// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/TERC20Standalone.sol";
import "./TERC20TestShare.sol";

contract TERC20TestStandalone is Test, TERC20TestShare {
    function setUp() public {
        token = new TERC20Standalone(admin, testName, testSymbol, testDecimals);
    }

    /*//////////////////////////////////////////////////////////////
                        VERSION
    //////////////////////////////////////////////////////////////*/
    function testVersion() public view {
        testShareVersion();
    }

    /*//////////////////////////////////////////////////////////////
                          MINT
    //////////////////////////////////////////////////////////////*/

    function testMint() public {
        TERC20TestShare.testShareCanMint();
    }

    function testBatchMint() public {
        TERC20TestShare.testShareCanBatchMint();
    }

    /*//////////////////////////////////////////////////////////////
                           BURN
    //////////////////////////////////////////////////////////////*/

    function testBurn() public {
        TERC20TestShare.testShareCanBurn();
    }

    function testBatchBurn() public {
        TERC20TestShare.testShareCanBatchBurn();
    }

    /*//////////////////////////////////////////////////////////////
                           Access Control
    //////////////////////////////////////////////////////////////*/

    function testAttackerCannotBurnAndBatchBurn() public {
        TERC20TestShare.testShareAttackerCannotBurnAndBatchBurn();
    }

    function testAttackerCannotMintAndBatchMint() public {
        TERC20TestShare.testShareAttackerCannotMintAndBatchMint();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/
    function testAttackerCannotBatchBurnIfInvalidParameters() public {
        TERC20TestShare.testShareCannotBatchBurnIfInvalidParameters();
    }

    function testAttackerCannotBatchMintIfInvalidParameters() public {
        TERC20TestShare.testShareCannotBatchMintIfInvalidParameters();
    }

    /*//////////////////////////////////////////////////////////////
                        Deployment
    //////////////////////////////////////////////////////////////*/
    function testTERC20StandaloneDeployment() public {
        TERC20Standalone TERC20 = new TERC20Standalone(
            admin,
            testName,
            testSymbol,
            testDecimals
        );
        assertEq(TERC20.decimals(), testDecimals);
        assertEq(TERC20.name(), testName);
        assertEq(TERC20.symbol(), testSymbol);
        assertEq(TERC20.hasRole(DEFAULT_ADMIN_ROLE, admin), true);
        assertEq(TERC20.hasRole(MINTER_ROLE, admin), true);
        assertEq(TERC20.hasRole(BURNER_ROLE, admin), true);
        // Admin has all the roles
        assertEq(TERC20.hasRole(NOT_ROLE, admin), true);
    }
}
