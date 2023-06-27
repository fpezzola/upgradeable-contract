const { ethers, upgrades } = require("hardhat");

// TO DO: Place the address of your proxy here!
const proxyAddress = "0x455378B2d37862e01eB62021F37cC5bFd06e2a6D";

async function main() {
  const VendingMachineV6 = await ethers.getContractFactory("VendingMachineV6");
  const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV6);
  await upgraded.deployed();
  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddress
  );

  console.log("The current contract owner is: " + (await upgraded.owner()));
  console.log("Implementation contract address: " + implementationAddress);
}

main();
