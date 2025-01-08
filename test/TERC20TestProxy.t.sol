// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/TERC20Upgradeable.sol";
import "./TERC20TestShare.sol";
import { Upgrades } from "openzeppelin-foundry-upgrades/Upgrades.sol";



contract TERC20TestProxy is Test, TERC20TestShare {

    function setUp() public{
        address proxy = Upgrades.deployTransparentProxy(
            "TERC20Upgradeable.sol",
            admin,
            abi.encodeCall(TERC20Upgradeable.initialize, ( admin, testName, testSymbol, testDecimals))
        );
       token = TERC20Upgradeable(proxy);
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


    /*//////////////////////////////////////////////////////////////
                           BURN
    //////////////////////////////////////////////////////////////*/

    function testBurn() public {
        TERC20TestShare.testShareCanBurn();
    }

    function testBurnBatch() public {
        TERC20TestShare.testShareCanBurnBatch();
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
    function testTERC20UpgradeableDeployment() public {
        address proxy = Upgrades.deployTransparentProxy(
            "TERC20Upgradeable.sol",
            admin,
            abi.encodeCall(TERC20Upgradeable.initialize, ( admin, testName, testSymbol, testDecimals))
        );
        TERC20Upgradeable TERC20 = TERC20Upgradeable(proxy);
        assertEq(TERC20.decimals(), testDecimals);
        assertEq(TERC20.name(), testName);
        assertEq(TERC20.symbol(), testSymbol);
    }
}
