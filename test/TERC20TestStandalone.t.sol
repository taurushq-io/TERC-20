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
    function testVersion() public view{
        testShareVersion();
    }
    /*//////////////////////////////////////////////////////////////
                          MINT
    //////////////////////////////////////////////////////////////*/

    function testMint() public {
        TERC20TestShare.testShareCanMint();
    }

    function testMintBatch() public {
        TERC20TestShare.testShareCanMintBatch();
    }

    function testMintBatchSingleValue() public {
        TERC20TestShare.testShareCanMintBatchSingleValue();
    }

    /*//////////////////////////////////////////////////////////////
                           BURN
    //////////////////////////////////////////////////////////////*/

    function testBurn() public {
        TERC20TestShare.testShareCanBurn();
    }

    function testBurnBatch() public {
        TERC20TestShare.testShareCanBurnBatch();
    }

    function testBurnBatchSingleValue() public {
        TERC20TestShare.testShareCanBurnBatchSingleValue();
    }

    /*//////////////////////////////////////////////////////////////
                           Access Control
    //////////////////////////////////////////////////////////////*/

    function testAttackerCannotBurnAndBurnBatch() public {
        TERC20TestShare.testShareAttackerCannotBurnAndBurnBatch();
    }

    function testAttackerCannotMintAndMintBatch() public {
        TERC20TestShare.testShareAttackerCannotMintAndMintBatch();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/
    function testAttackerCannotBurnBatchIfInvalidParameters() public {
        TERC20TestShare.testShareCannotBurnBatchIfInvalidParameters();
    }

    function testAttackerCannotMintBatchIfInvalidParameters() public {
        TERC20TestShare.testShareCannotMintBatchIfInvalidParameters();
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
    }
}
