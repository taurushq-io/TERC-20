## TERC-20

This project contains two basic ERC-20 tokens:

- `TERC20Standalone` for an immutable deployment, without proxy
- `TERC20Upgradeable` for an upgradeable deployment, with a compatible proxy (Transparent or Beacon)

## Common characteristics

These ERC-20 tokens have the following characteristics:

**Mint**

- A mint function only accessible with the MINTER role

- Two mint batch functions only accessible with the MINTER role

**Burn**

- A burn function only accessible with the BURNER role
- Two burn in batch functions only accessible with the BURNER role

**ERC20**

- At deployment, the issuer can set the name, symbol and decimals.

- Once deployed, it is no longer possible to modify these values except via an upgrade in the case of the proxy.

## Schema

### TERC20Standalone

#### Inheritance

![surya_inheritance_TERC20Standalone.sol](./doc/surya/surya_inheritance/surya_inheritance_TERC20Standalone.sol.png)

#### Graph

![surya_graph_TERC20Standalone.sol](./doc/surya/surya_graph/surya_graph_TERC20Standalone.sol.png)



### TERC20 Upgradeable

#### Inheritance

![surya_inheritance_TERC20Upgradeable.sol](./doc/surya/surya_inheritance/surya_inheritance_TERC20Upgradeable.sol.png)

#### Graph

![surya_graph_TERC20Upgradeable.sol](./doc/surya/surya_graph/surya_graph_TERC20Upgradeable.sol.png)

## Surya Description Report

### Contracts Description Table

#### TERC20Standalone

|       Contract       |       Type        |               Bases               |                |               |
| :------------------: | :---------------: | :-------------------------------: | :------------: | :-----------: |
|          └           | **Function Name** |          **Visibility**           | **Mutability** | **Modifiers** |
|                      |                   |                                   |                |               |
| **TERC20Standalone** |  Implementation   | ERC20, AccessControl, TERC20Share |                |               |
|          └           |   <Constructor>   |             Public ❗️              |       🛑        |     ERC20     |
|          └           |     decimals      |             Public ❗️              |                |      NO❗️      |
|          └           |       mint        |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |     mintBatch     |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |     mintBatch     |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |       burn        |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |     burnBatch     |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |     burnBatch     |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |      hasRole      |             Public ❗️              |                |      NO❗️      |

#### TERC20Upgradeable

|       Contract        |                Type                |                            Bases                             |                |                  |
| :-------------------: | :--------------------------------: | :----------------------------------------------------------: | :------------: | :--------------: |
|           └           |         **Function Name**          |                        **Visibility**                        | **Mutability** |  **Modifiers**   |
|                       |                                    |                                                              |                |                  |
| **TERC20Upgradeable** |           Implementation           | Initializable, ERC20Upgradeable, AccessControlUpgradeable, TERC20Share |                |                  |
|           └           |           <Constructor>            |                           Public ❗️                           |       🛑        |       NO❗️        |
|           └           |             initialize             |                           Public ❗️                           |       🛑        |   initializer    |
|           └           | __TERC20Upgradeable_init_unchained |                          Internal 🔒                          |       🛑        | onlyInitializing |
|           └           |              decimals              |                           Public ❗️                           |                |       NO❗️        |
|           └           |                mint                |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └           |             mintBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └           |             mintBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └           |                burn                |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └           |             burnBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └           |             burnBatch              |                           Public ❗️                           |       🛑        |     onlyRole     |
|           └           |              hasRole               |                           Public ❗️                           |                |       NO❗️        |
|           └           |    _getTERC20UpgradeableStorage    |                          Private 🔐                           |                |                  |

### Legend

| Symbol | Meaning                   |
| :----: | ------------------------- |
|   🛑    | Function can modify state |
|   💵    | Function is payable       |



## Dependencies

The toolchain includes the following components, where the versions are the latest ones that we tested:

- Foundry
- Solidity 0.8.28 (via solc-js)
- OpenZeppelin Contracts (submodule) [v5.1.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.0.2)
- OpenZeppelin Contracts upgradeable (submodule) [v5.1.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.0.2)

## Audit

See [slither](./doc/audit/tool/slither-report.md)

## Tools

### Prettier

```bash
npx prettier --write --plugin=prettier-plugin-solidity 'src/**/*.sol'
```

```bash
npx prettier --write --plugin=prettier-plugin-solidity 'src/**/*.sol'
```

### Slither

```bash
slither .  --checklist --filter-paths "openzeppelin-contracts|test|forge-std" > slither-report.md
```

### Surya

See [./doc/script](./doc/script)

### Foundry

Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Usage

*Explain how it works.*


### Toolchain installation

The contracts are developed and tested with [Foundry](https://book.getfoundry.sh), a smart contract development toolchain.

To install the Foundry suite, please refer to the official instructions in the [Foundry book](https://book.getfoundry.sh/getting-started/installation).

### Initialization

You must first initialize the submodules, with

```
forge install
```

See also the command's [documentation](https://book.getfoundry.sh/reference/forge/forge-install).

Later you can update all the submodules with:

```
forge update
```

See also the command's [documentation](https://book.getfoundry.sh/reference/forge/forge-update).

### Compilation

The official documentation is available in the Foundry [website](https://book.getfoundry.sh/reference/forge/build-commands) 

```
 forge build
```

### Testing

You can run the tests with

```
forge test
```

To run a specific test, use

```
forge test --match-contract <contract name> --match-test <function name>
```

See also the test framework's [official documentation](https://book.getfoundry.sh/forge/tests), and that of the [test commands](https://book.getfoundry.sh/reference/forge/test-commands).

### Coverage

* Perform a code coverage

```
forge coverage
```

* Generate LCOV report

```
forge coverage --report lcov
```

- Generate `index.html`

```bash
forge coverage --ffi --report lcov && genhtml lcov.info --branch-coverage --output-dir coverage 
```

See [Solidity Coverage in VS Code with Foundry](https://mirror.xyz/devanon.eth/RrDvKPnlD-pmpuW7hQeR5wWdVjklrpOgPCOA-PJkWFU) & [Foundry forge coverage](https://www.rareskills.io/post/foundry-forge-coverage)

### Documentation

[https://book.getfoundry.sh/](https://book.getfoundry.sh/)



## Intellectual property

The original code is copyright (c) Taurus 2025, and is released under [MIT license](https://github.com/taurushq-io/tg-bridge-contracts-CCIP/blob/main/LICENSE).
