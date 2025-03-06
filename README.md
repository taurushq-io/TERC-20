## TERC-20

This project contains two basic ERC-20 tokens:

- `TERC20Standalone` for an immutable deployment, without proxy
- `TERC20Upgradeable` for an upgradeable deployment, with a compatible proxy (Transparent or Beacon)

## Common features

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

## Access control

Access Control is managed with the OpenZeppelin library [AccessControl](https://docs.openzeppelin.com/contracts/5.x/api/access#AccessControl) which implements a role-based access control mechanisms.

- Default Admin Role

The most important role is the role `DEFAULT_ADMIN_ROLE`. This role manage all others roles.

This role is also its own admin: it has permission to grant and revoke this role. 

warning: Extra precautions should be taken to secure accounts that have been granted it.

- Supply management role

Two roles BURNER_ROLE and MINTER_ROLE allow their members to respectively mint or burn tokens.

### Schema



![TERC20.drawio](./doc/TERC20.drawio.png)

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

### TERC20Standalone

|       Contract       |        Type        |               Bases               |                |               |
| :------------------: | :----------------: | :-------------------------------: | :------------: | :-----------: |
|          └           | **Function Name**  |          **Visibility**           | **Mutability** | **Modifiers** |
|                      |                    |                                   |                |               |
| **TERC20Standalone** |   Implementation   | ERC20, AccessControl, TERC20Share |                |               |
|          └           |   <Constructor>    |             Public ❗️              |       🛑        |     ERC20     |
|          └           |      decimals      |             Public ❗️              |                |      NO❗️      |
|          └           |      version       |             Public ❗️              |                |      NO❗️      |
|          └           |        mint        |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |     batchMint      |             Public ❗️              |       🛑        |   onlyRole    |
|          └           | batchMintSameValue |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |        burn        |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |     batchBurn      |             Public ❗️              |       🛑        |   onlyRole    |
|          └           | batchBurnSameValue |             Public ❗️              |       🛑        |   onlyRole    |
|          └           |      hasRole       |             Public ❗️              |                |      NO❗️      |

### TERC20Upgradeable

|       Contract        |                Type                |                            Bases                             |                |                  |
| :-------------------: | :--------------------------------: | :----------------------------------------------------------: | :------------: | :--------------: |
|           └           |         **Function Name**          |                        **Visibility**                        | **Mutability** |  **Modifiers**   |
|                       |                                    |                                                              |                |                  |
| **TERC20Upgradeable** |           Implementation           | Initializable, ERC20Upgradeable, AccessControlUpgradeable, TERC20Share, TERC20UpgradeableBurn, TERC20UpgradeableMint |                |                  |
|           └           |           <Constructor>            |                           Public ❗️                           |       🛑        |       NO❗️        |
|           └           |             initialize             |                           Public ❗️                           |       🛑        |   initializer    |
|           └           | __TERC20Upgradeable_init_unchained |                          Internal 🔒                          |       🛑        | onlyInitializing |
|           └           |              decimals              |                           Public ❗️                           |                |       NO❗️        |
|           └           |              version               |                           Public ❗️                           |                |       NO❗️        |
|           └           |              hasRole               |                           Public ❗️                           |                |       NO❗️        |
|           └           |    _getTERC20UpgradeableStorage    |                          Private 🔐                           |                |                  |

#### TERC20UpgradeableMint

|         Contract          |        Type        |                            Bases                            |                |               |
| :-----------------------: | :----------------: | :---------------------------------------------------------: | :------------: | :-----------: |
|             └             | **Function Name**  |                       **Visibility**                        | **Mutability** | **Modifiers** |
|                           |                    |                                                             |                |               |
| **TERC20UpgradeableMint** |   Implementation   | ERC20Upgradeable, AccessControlUpgradeable, TERC20ShareMint |                |               |
|             └             |        mint        |                          Public ❗️                           |       🛑        |   onlyRole    |
|             └             |     batchMint      |                          Public ❗️                           |       🛑        |   onlyRole    |
|             └             | batchMintSameValue |                          Public ❗️                           |       🛑        |   onlyRole    |

#### TERC20UpgradeableBurn

|         Contract          |        Type        |                            Bases                            |                |               |
| :-----------------------: | :----------------: | :---------------------------------------------------------: | :------------: | :-----------: |
|             └             | **Function Name**  |                       **Visibility**                        | **Mutability** | **Modifiers** |
|                           |                    |                                                             |                |               |
| **TERC20UpgradeableBurn** |   Implementation   | ERC20Upgradeable, AccessControlUpgradeable, TERC20ShareBurn |                |               |
|             └             |        burn        |                          Public ❗️                           |       🛑        |   onlyRole    |
|             └             |     batchBurn      |                          Public ❗️                           |       🛑        |   onlyRole    |
|             └             | batchBurnSameValue |                          Public ❗️                           |       🛑        |   onlyRole    |

### Legend

| Symbol | Meaning                   |
| :----: | ------------------------- |
|   🛑    | Function can modify state |
|   💵    | Function is payable       |



## Dependencies

The toolchain includes the following components, where the versions are the latest ones that we tested:

- Foundry / forge 1.0.0-stable
- Solidity 0.8.28 (via solc-js)
- OpenZeppelin Contracts (submodule) [v5.1.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.0.2)
- OpenZeppelin Contracts upgradeable (submodule) [v5.1.0](https://github.com/OpenZeppelin/openzeppelin-contracts/releases/tag/v5.0.2)

## Security and Audit

### Vulnerability disclosure

Please see [SECURITY.md](./SECURITY.md).

### Audit

Report made by [SecFault Security](https://secfault-security.com)

See our comment here [report file](./doc/audit/secfault-report.md)

### Audit tools

#### Slither

 [Report file](./doc/audit/tool/slither-report.md)

See [crytic/slither](https://github.com/crytic/slither)

```bash
slither .  --checklist --filter-paths "openzeppelin-contracts|test|forge-std" > slither-report.md
```

#### Mythril

 [Report file](./doc/audit/tool/mythril-report.md)

```bash
myth analyze src/TERC20Standalone.sol --solc-json solc_setting.json
```

See [Consensys/mythril](https://github.com/Consensys/mythril)

#### Cyfrin Aderyn

 [Report file](./doc/audit/tool/aderyn-report.md)

```
aderyn
```

See [Cyfrin/aderyn](https://github.com/Cyfrin/aderyn)

## Tools

### Surya

See [./doc/script](./doc/script) and [Consensys/surya](https://github.com/Consensys/surya)

### Prettier

```bash
npx prettier --write --plugin=prettier-plugin-solidity 'src/**/*.sol'
```

```bash
npx prettier --write --plugin=prettier-plugin-solidity 'test/**/*.sol'
```

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
