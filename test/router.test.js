const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('VeilSwapRouter', function () {
  it('deploys', async function () {
    const Router = await ethers.getContractFactory('VeilSwapRouter');
    const router = await Router.deploy(ethers.constants.AddressZero);
    await router.deployed();
    expect(await router.verifier()).to.equal(ethers.constants.AddressZero);
  });
});
