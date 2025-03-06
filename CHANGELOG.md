# CHANGELOG

Please follow <https://changelog.md/> conventions.

## Checklist

> Before a new release, perform the following tasks

- Code: Update the version name in [TERC20Share](./src/lib/TERC20Share.sol), variable VERSION
- Run linter (prettier)

- Documentation
  - Perform a code coverage and update the files in the corresponding directory [./doc/coverage](./doc/coverage)
  - Perform an audit with several audit tools (Mythril, Slither, etc), update the report in the corresponding directory [./doc/audits/tool](./doc/audit/tool)
  - Update surya doc by running the 3 scripts in [./doc/script](./doc/script)
  - Update changelog

## 1.0.0

- Add function `version` to return contract version to use the same name as [ERC-3643](https://eips.ethereum.org/EIPS/eip-3643)
- Rename functions `burnBatch`, `mintBatch`and their corresponding events in `batchBurn`, `batchMint` to use the same name as [ERC-3643](https://eips.ethereum.org/EIPS/eip-3643)
- Rename the overloading functions `batchBurn`and `batchMint`in `batchBurnSameValue`and `batchMintSameValue`, as well as their corresponding versions (recommended in the audit report)
- Separate Burn and Mint features from the main contract.

## 0.1.0 - 20240110

First release !
