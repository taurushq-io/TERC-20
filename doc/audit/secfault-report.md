# Secfault report

## Potential Frontrunning issues in ERC-20

This issue is well known among the ecosystem with no known exploit.

Solution to this, for example, by adding functions  `increaseAllowance`and `decreaseAllowance`are not part of ERC-20 and can be used by attackers for phishing.

See  also [openzeppelin-contracts/issues/4583](https://github.com/OpenZeppelin/openzeppelin-contracts/issues/4583)

## Possible Confusion due to Overloaded Functions

For each burn/mint features has been renamed:

- `batchMint`has been renamed in `batchMintSameValue`
- `batchBurn`has been renamed in `batchBurnSameValue`

