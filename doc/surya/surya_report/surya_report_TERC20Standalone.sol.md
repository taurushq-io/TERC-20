## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./TERC20Standalone.sol | ff3df10edde6fbe7c12f1d26c4cad0dc0a8da04b |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **TERC20Standalone** | Implementation | ERC20, AccessControl, TERC20Share |||
| └ | <Constructor> | Public ❗️ | 🛑  | ERC20 |
| └ | decimals | Public ❗️ |   |NO❗️ |
| └ | version | Public ❗️ |   |NO❗️ |
| └ | mint | Public ❗️ | 🛑  | onlyRole |
| └ | batchMint | Public ❗️ | 🛑  | onlyRole |
| └ | burn | Public ❗️ | 🛑  | onlyRole |
| └ | batchBurn | Public ❗️ | 🛑  | onlyRole |
| └ | hasRole | Public ❗️ |   |NO❗️ |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
