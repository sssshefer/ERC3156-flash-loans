import { loadFixture, ethers, expect } from "./setup";

describe("FlashBorrower", function () {
  async function deploy() {
    const [owner, user1] = await ethers.getSigners();

    const ShefTokenFactory = await ethers.getContractFactory("ShefToken");
    const shefToken = await ShefTokenFactory.deploy();
    await shefToken.waitForDeployment();

    const FlashBorrowerFactory = await ethers.getContractFactory("FlashBorrower");
    const borrower = await FlashBorrowerFactory.deploy(shefToken);
    await borrower.waitForDeployment();

    shefToken.mint(borrower, 10);

    return { borrower, shefToken, user1, owner}
  }

  it("flashBorrow works", async function () {
    const {  borrower, shefToken, user1, owner} = await loadFixture(deploy);

    const amount = 2000;
    const fee = await shefToken.flashFee(shefToken, amount);

    await expect(await shefToken.balanceOf(owner)).to.eq(0)
    await expect(borrower.flashBorrow(shefToken, amount, ethers.solidityPackedKeccak256(["uint"], [1]))).to.emit(borrower, "ActionDefault");
    await expect(await shefToken.balanceOf(owner)).to.eq(fee)
  })
});
