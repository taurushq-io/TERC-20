## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./TERC20Upgradeable.sol | 161134f7ddb8637bb4ff1a05117aae757b06178d |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC20Upgradeable** | Implementation | Initializable, ERC20Upgradeable, AccessControlUpgradeable, TERC20Share |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | initialize | Public ❗️ | 🛑  | initializer |
| └ | __TERC20Upgradeable_init_unchained | Internal 🔒 | 🛑  | onlyInitializing |
| └ | decimals | Public ❗️ |   |NO❗️ |
| └ | version | Public ❗️ |   |NO❗️ |
| └ | mint | Public ❗️ | 🛑  | onlyRole |
| └ | batchMint | Public ❗️ | 🛑  | onlyRole |
| └ | burn | Public ❗️ | 🛑  | onlyRole |
| └ | batchBurn | Public ❗️ | 🛑  | onlyRole |
| └ | hasRole | Public ❗️ |   |NO❗️ |
| └ | _getTERC20UpgradeableStorage | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
