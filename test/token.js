const { expect } = require("chai");
const { ethers } = require("hardhat"); //redundant because it's available in global scope

describe("Token contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("Token"); //this method is added to original ethers by hardhat: https://hardhat.org/plugins/nomiclabs-hardhat-ethers

    const hardhatToken = await Token.deploy();

    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });
});