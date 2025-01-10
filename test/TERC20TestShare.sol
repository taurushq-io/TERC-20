// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/lib/TERC20Share.sol";

contract TERC20TestShare is Test {
    TERC20Share internal token;

    address admin = address(0x1);
    address minter = address(0x2);
    address burner = address(0x3);
    address holder = address(0x4);
    address attacker = address(0x5);

    uint8 testDecimals = 6;
    string testName = "testnName";
    string testSymbol = "testSymbol";

    // Custom error openZeppelin
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    // Events
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

    // Errors
    error Burn_EmptyAccounts();
    error Burn_AccountsValueslengthMismatch();
    error Mint_EmptyAccounts();
    error Mint_AccountsValueslengthMismatch();

    /*//////////////////////////////////////////////////////////////
                        VERSION
    //////////////////////////////////////////////////////////////*/
    function testShareVersion() internal view{
        assertEq(token.VERSION(), "0.1.0");
    }
    /*//////////////////////////////////////////////////////////////
                          MINT
    //////////////////////////////////////////////////////////////*/
    function testShareCanMint() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);
        vm.startPrank(minter);
        uint256 amount = 100;

        // Events
        vm.expectEmit(true, true, true, true);
        emit Mint(minter, holder, amount);

        // Act
        token.mint(holder, amount);

        // Assert
        // check balance
        assertEq(token.balanceOf(holder), amount);
        vm.stopPrank();
    }

    function testShareCanMintBatch() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        uint256[] memory values = new uint256[](2);
        values[0] = 100;
        values[1] = 200;

        // Events
        vm.expectEmit(true, true, false, true);
        emit MintBatch(minter, accounts, values);
        vm.prank(minter);
        // Act
        token.mintBatch(accounts, values);

        // check balances
        assertEq(token.balanceOf(holder), 100);
        assertEq(token.balanceOf(admin), 200);
        vm.stopPrank();
    }

    function testShareCanMintBatchSingleValue() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        uint256 mintValue = 100;

        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        // Events
        vm.expectEmit(true, true, false, true);
        emit MintBatch(minter, accounts, mintValue);
        vm.prank(minter);
        // Act
        token.mintBatch(accounts, mintValue);

        // check balances
        assertEq(token.balanceOf(holder), mintValue);
        assertEq(token.balanceOf(admin), mintValue);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                           BURN
    //////////////////////////////////////////////////////////////*/

    function testShareCanBurn() internal {
        // Arrange
        vm.startPrank(admin);
        uint256 mintAmount = 100;

        // Mint tokens first
        token.mint(holder, mintAmount);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);
        uint256 burnAmount = 50;

        // Events
        vm.expectEmit(true, true, true, true);
        emit Burn(burner, holder, burnAmount);

        // Act
        token.burn(holder, burnAmount);

        // Assert
        // Check balance after burn
        assertEq(token.balanceOf(holder), mintAmount - burnAmount);
        vm.stopPrank();
    }

    function testShareCanBurnBatch() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.mintBatch(holders, mintValues);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256[] memory burnValues = new uint256[](2);
        burnValues[0] = 50;
        burnValues[1] = 150;

        // Events
        vm.expectEmit(true, true, false, true);
        emit BurnBatch(burner, holders, burnValues);

        // Act
        token.burnBatch(holders, burnValues);

        // Assert
        // Check balance
        assertEq(token.balanceOf(holder), mintValues[0] - burnValues[0]);
        assertEq(token.balanceOf(admin), mintValues[1] - burnValues[1]);
        vm.stopPrank();
    }

    function testShareCanBurnBatchSingleValue() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.mintBatch(holders, mintValues);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256 burnValue = 100;
        // Events
        vm.expectEmit(true, true, false, true);
        emit BurnBatch(burner, holders, burnValue);

        // Act
        token.burnBatch(holders, burnValue);

        // Assert
        // Check balance
        assertEq(token.balanceOf(holder), mintValues[0] - burnValue);
        assertEq(token.balanceOf(admin), mintValues[1] - burnValue);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/

    function testShareCannotBurnBatchIfInvalidParameters() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.mintBatch(holders, mintValues);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256[] memory burnValues = new uint256[](1);

        // Act
        vm.expectRevert(
            abi.encodeWithSelector(Burn_AccountsValueslengthMismatch.selector)
        );
        token.burnBatch(holders, burnValues);

        vm.expectRevert(abi.encodeWithSelector(Burn_EmptyAccounts.selector));
        holders = new address[](0);
        token.burnBatch(holders, burnValues);

        // Single Value
        vm.expectRevert(abi.encodeWithSelector(Burn_EmptyAccounts.selector));
        holders = new address[](0);
        token.burnBatch(holders, 100);
    }

    function testShareCannotMintBatchIfInvalidParameters() internal {
        // Arrange
        vm.prank(admin);
        token.grantRole(MINTER_ROLE, minter);

        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        uint256[] memory values = new uint256[](1);
        values[0] = 100;
        vm.startPrank(minter);
        // Act
        vm.expectRevert(
            abi.encodeWithSelector(Mint_AccountsValueslengthMismatch.selector)
        );
        token.mintBatch(accounts, values);
        accounts = new address[](0);
        vm.expectRevert(abi.encodeWithSelector(Mint_EmptyAccounts.selector));
        token.mintBatch(accounts, values);

        // Single Value
        vm.expectRevert(abi.encodeWithSelector(Mint_EmptyAccounts.selector));
        token.mintBatch(accounts, 100);
    }

    /*//////////////////////////////////////////////////////////////
                           Access Control
    //////////////////////////////////////////////////////////////*/
    function testShareAttackerCannotBurnAndBurnBatch() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.mintBatch(holders, mintValues);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(attacker);

        uint256[] memory burnValues = new uint256[](2);
        burnValues[0] = 50;
        burnValues[1] = 150;

        // Act
        // Burn batch
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                BURNER_ROLE
            )
        );
        token.burnBatch(holders, burnValues);
        //Single Value
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                BURNER_ROLE
            )
        );
        token.burnBatch(holders, 100);
        // burn
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                BURNER_ROLE
            )
        );
        token.burn(holder, 100);
    }

    function testShareAttackerCannotMintAndMintBatch() internal {
        // Arrange
        address[] memory accounts = new address[](2);
        accounts[0] = holder;
        accounts[1] = admin;

        uint256[] memory values = new uint256[](2);
        values[0] = 100;
        values[1] = 200;

        vm.startPrank(attacker);
        // Act
        // mint
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                MINTER_ROLE
            )
        );
        token.mint(holder, 100);
        // MintBatch
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                MINTER_ROLE
            )
        );
        token.mintBatch(accounts, values);
        // MintBatch Single Value
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                MINTER_ROLE
            )
        );
        token.mintBatch(accounts, 100);
    }
}
