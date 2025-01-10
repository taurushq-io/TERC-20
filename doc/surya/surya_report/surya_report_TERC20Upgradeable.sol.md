## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./TERC20Upgradeable.sol | b7eba2535095e39050526e4b18447219fdfd22f4 |


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
| └ | mint | Public ❗️ | 🛑  | onlyRole |
| └ | mintBatch | Public ❗️ | 🛑  | onlyRole |
| └ | mintBatch | Public ❗️ | 🛑  | onlyRole |
| └ | burn | Public ❗️ | 🛑  | onlyRole |
| └ | burnBatch | Public ❗️ | 🛑  | onlyRole |
| └ | burnBatch | Public ❗️ | 🛑  | onlyRole |
| └ | hasRole | Public ❗️ |   |NO❗️ |
| └ | _getTERC20UpgradeableStorage | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
