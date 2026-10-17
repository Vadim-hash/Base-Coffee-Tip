const hre = require("hardhat");

async function main() {
  const BaseCoffee = await hre.ethers.getContractFactory("BaseCoffee");
  const coffee = await BaseCoffee.deploy();
  await coffee.deployed();

  console.log("BaseCoffee tipping contract deployed to:", coffee.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
