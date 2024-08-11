import { loadFixture, ethers, expect } from "./setup";

describe("FlashBorrower", function () {
  async function deploy() {
    const [user1, user2, user3] = await ethers.getSigners();

    const FlashBorrowerFactory = await ethers.getContractFactory("Implementation");
    const borrower = await FlashBorrowerFactory.deploy();
    await borrower.waitForDeployment();

    return { user1, user2, user3, borrower }
  }

  it("Should delegate", async function () {
    const { user1, user2, user3, borrower } = await loadFixture(deploy);

  })
});
