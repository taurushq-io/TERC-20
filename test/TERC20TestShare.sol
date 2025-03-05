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
    bytes32 public constant DEFAULT_ADMIN_ROLE = keccak256("DEFAULT_ADMIN_ROLE");
    bytes32 public constant NOT_ROLE = keccak256("NOT_ROLE");

    // Events
    event Burn(address indexed burner, address indexed account, uint256 value);
    event BatchBurn(
        address indexed burner,
        address[] accounts,
        uint256[] values
    );
    event Mint(address indexed minter, address indexed account, uint256 value);
    event BatchMint(
        address indexed minter,
        address[] accounts,
        uint256[] values
    );

    // Errors
    error Burn_EmptyAccounts();
    error Burn_AccountsValueslengthMismatch();
    error Mint_EmptyAccounts();
    error Mint_AccountsValueslengthMismatch();

    /*//////////////////////////////////////////////////////////////
                        VERSION
    //////////////////////////////////////////////////////////////*/
    function testShareVersion() internal view {
        assertEq(token.version(), "1.0.0");
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

    function testShareCanBatchMint() internal {
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
        emit BatchMint(minter, accounts, values);
        vm.prank(minter);
        // Act
        token.batchMint(accounts, values);

        // check balances
        assertEq(token.balanceOf(holder), 100);
        assertEq(token.balanceOf(admin), 200);
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

    function testShareCanBatchBurn() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.batchMint(holders, mintValues);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256[] memory burnValues = new uint256[](2);
        burnValues[0] = 50;
        burnValues[1] = 150;

        // Events
        vm.expectEmit(true, true, false, true);
        emit BatchBurn(burner, holders, burnValues);

        // Act
        token.batchBurn(holders, burnValues);

        // Assert
        // Check balance
        assertEq(token.balanceOf(holder), mintValues[0] - burnValues[0]);
        assertEq(token.balanceOf(admin), mintValues[1] - burnValues[1]);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                          Invalid Parameters
    //////////////////////////////////////////////////////////////*/

    function testShareCannotBatchBurnIfInvalidParameters() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.batchMint(holders, mintValues);
        vm.stopPrank();

        vm.prank(admin);
        token.grantRole(BURNER_ROLE, burner);

        vm.startPrank(burner);

        uint256[] memory burnValues = new uint256[](1);

        // Act
        vm.expectRevert(
            abi.encodeWithSelector(Burn_AccountsValueslengthMismatch.selector)
        );
        token.batchBurn(holders, burnValues);
        vm.expectRevert(abi.encodeWithSelector(Burn_EmptyAccounts.selector));
        holders = new address[](0);
        token.batchBurn(holders, burnValues);
    }

    function testShareCannotBatchMintIfInvalidParameters() internal {
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
        token.batchMint(accounts, values);
        accounts = new address[](0);
        vm.expectRevert(abi.encodeWithSelector(Mint_EmptyAccounts.selector));
        token.batchMint(accounts, values);
    }

    /*//////////////////////////////////////////////////////////////
                           Access Control
    //////////////////////////////////////////////////////////////*/
    function testShareAttackerCannotBurnAndBatchBurn() internal {
        // Arrange
        vm.startPrank(admin);

        address[] memory holders = new address[](2);
        holders[0] = holder;
        holders[1] = admin;

        uint256[] memory mintValues = new uint256[](2);
        mintValues[0] = 100;
        mintValues[1] = 200;

        // Mint tokens first
        token.batchMint(holders, mintValues);
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
        token.batchBurn(holders, burnValues);
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

    function testShareAttackerCannotMintAndBatchMint() internal {
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
        // batchMint
        vm.expectRevert(
            abi.encodeWithSelector(
                AccessControlUnauthorizedAccount.selector,
                attacker,
                MINTER_ROLE
            )
        );
        token.batchMint(accounts, values);
    }
}
