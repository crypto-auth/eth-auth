require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(await account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
};

// 1. npx hardhat compile
// 2. npx hardhat node
// 3. npx hardhat run --network localhost scripts/deployAuthClient.js
// 4. npx hardhat console --network localhost

// Check balance in console:
// const authClientt = await ethers.getContractFactory('AuthClient');
// const ac = await authClientt.attach('0x5FbDB2315678afecb367f032d93F642f64180aa3');
// await ac.safeMint("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", "https://www.npoint.io/docs/0f539eb6ae939c0d751a");
// await ethers.provider.getBalance("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266");

//Without payable:
// Deploy:  BigNumber { value: "9999996827704125000000" }
//          BigNumber { value: "9999996696603805671118" }
// Mint:    BigNumber { value: "9999996696603805671118" }

// 131100319328882 - not payable
// 131162498578202 - payable


//With payable:
// Deploy:  BigNumber { value: "9999996768834125000000" }
// Mint:    BigNumber { value: "9999996637671626421798" }