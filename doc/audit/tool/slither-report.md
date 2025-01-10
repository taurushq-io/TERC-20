**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [assembly](#assembly) (1 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [solc-version](#solc-version) (1 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
 - [immutable-states](#immutable-states) (1 results) (Optimization)
## assembly

> Required by ERC-2701

Impact: Informational
Confidence: High
 - [ ] ID-0
	[TERC20Upgradeable._getTERC20UpgradeableStorage()](src/TERC20Upgradeable.sol#L147-L155) uses assembly
	- [INLINE ASM](src/TERC20Upgradeable.sol#L152-L154)

src/TERC20Upgradeable.sol#L147-L155



## unused-state

> Used by ERC-2701 through assembly

Impact: Informational
Confidence: High

 - [ ] ID-4
   [TERC20Upgradeable.TERC20UpgradeableStorageLocation](src/TERC20Upgradeable.sol#L17-L18) is never used in [TERC20Upgradeable](src/TERC20Upgradeable.sol#L9-L243)

src/TERC20Upgradeable.sol#L17-L18



## pragma

> Solidity version is set in the config file

Impact: Informational
Confidence: High
 - [ ] ID-1
	2 different versions of Solidity are used:
	- Version constraint ^0.8.20 is used by:
 		- lib/openzeppelin-contracts/contracts/access/AccessControl.sol#4
		- lib/openzeppelin-contracts/contracts/access/IAccessControl.sol#4
		- lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3
		- lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4
		- lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4
		- lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4
		- lib/openzeppelin-contracts/contracts/utils/Context.sol#4
		- lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4
		- lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#4
		- lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#4
	- Version constraint ^0.8.27 is used by:
 		- src/TERC20Standalone.sol#2
		- src/TERC20Upgradeable.sol#2
		- src/lib/TERC20Share.sol#2

## solc-version

> Solidity version is set in the config file

Impact: Informational
Confidence: High
 - [ ] ID-2
	Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
	 It is used by:
	- lib/openzeppelin-contracts/contracts/access/AccessControl.sol#4
	- lib/openzeppelin-contracts/contracts/access/IAccessControl.sol#4
	- lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3
	- lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4
	- lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4
	- lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4
	- lib/openzeppelin-contracts/contracts/utils/Context.sol#4
	- lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4
	- lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#4
	- lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#4

## naming-convention
Impact: Informational
Confidence: High

 - [ ] ID-3
Function [TERC20Upgradeable.__TERC20Upgradeable_init_unchained(address,uint8)](src/TERC20Upgradeable.sol#L44-L51) is not in mixedCase

src/TERC20Upgradeable.sol#L44-L51

> Same notation as OpenZeppelin, see https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/8c63b58ff08275284c120c561b3bc14090b87c51/contracts/token/ERC20/ERC20Upgradeable.sol#L62


 - [ ] ID-4
Constant [TERC20Upgradeable.TERC20UpgradeableStorageLocation](src/TERC20Upgradeable.sol#L22-L23) is not in UPPER_CASE_WITH_UNDERSCORES

src/TERC20Upgradeable.sol#L22-L23

> Same notation as OpenZeppelin see https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/8c63b58ff08275284c120c561b3bc14090b87c51/contracts/token/ERC20/ERC20Upgradeable.sol#L44
