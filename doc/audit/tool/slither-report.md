**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [assembly](#assembly) (1 results) (Informational)
 - [naming-convention](#naming-convention) (2 results) (Informational)
 - [unused-state](#unused-state) (2 results) (Informational)
## assembly

> Required by ERC-7201

Impact: Informational
Confidence: High
 - [ ] ID-0
	[TERC20Upgradeable._getTERC20UpgradeableStorage()](src/TERC20Upgradeable.sol#L117-L125) uses assembly
	- [INLINE ASM](src/TERC20Upgradeable.sol#L122-L124)

src/TERC20Upgradeable.sol#L117-L125


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-1
Function [TERC20Upgradeable.__TERC20Upgradeable_init_unchained(address,uint8)](src/TERC20Upgradeable.sol#L50-L57) is not in mixedCase

src/TERC20Upgradeable.sol#L50-L57

> Same notation as OpenZeppelin, see https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/8c63b58ff08275284c120c561b3bc14090b87c51/contracts/token/ERC20/ERC20Upgradeable.sol#L62


 - [ ] ID-2
Constant [TERC20Upgradeable.TERC20UpgradeableStorageLocation](src/TERC20Upgradeable.sol#L23-L24) is not in UPPER_CASE_WITH_UNDERSCORES

src/TERC20Upgradeable.sol#L23-L24

> Same notation as OpenZeppelin see https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/8c63b58ff08275284c120c561b3bc14090b87c51/contracts/token/ERC20/ERC20Upgradeable.sol#L44

## unused-state

> Incorrect, the constant is called in the function version()

Impact: Informational
Confidence: High
 - [ ] ID-3
[TERC20Share.VERSION](src/lib/TERC20Share.sol#L21) is never used in [TERC20Upgradeable](src/TERC20Upgradeable.sol#L13-L126)

src/lib/TERC20Share.sol#L21


 - [ ] ID-4
[TERC20Share.VERSION](src/lib/TERC20Share.sol#L21) is never used in [TERC20Standalone](src/TERC20Standalone.sol#L12-L75)

src/lib/TERC20Share.sol#L21

