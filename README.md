# Upgradeable Contracts

This project is an example of how to implement upgradeable contracts by using Hardhat's Proxy solution.

## Contracts

`contracts/VendingMachineV1.sol` is the initial implementation of a vending machine system.
...
`contracts/VendingMachineV6.sol` final implementation of a vending machine system.

## Scripts

`scripts/deployProxy.js` deploys a proxy with the `VendingMachineV1` default implementation
`scripts/upgradeProxy.js` upgrades proxy implementation using the specified contract.

## Environrment

The following variables are mandatory for being able to deploy and verify contracts

- `GOERLI_URL`: Goerli node URL.
- `GOERLI_PRIVATE_KEY`: Private Key with some `ETH` in Goerli to deploy contracts.
- `ETHERSCAN_KEY`: Etherscan key to verify contract's code.
