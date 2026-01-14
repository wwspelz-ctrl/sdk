const hre = require('hardhat');

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log('Deploying with:', deployer.address);

  const Router = await hre.ethers.getContractFactory('VeilSwapRouter');
  const router = await Router.deploy(hre.ethers.constants.AddressZero);
  await router.deployed();

  console.log('VeilSwapRouter:', router.address);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
