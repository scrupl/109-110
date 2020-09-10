const { expect } = require("chai");

describe("Token110", async () => {
  it("Should grant the DIRECTOR role to two founders at deploy time", async () => {
    const [accounts] = await getSigners();

    const Token110 = await ethers.getContractFactory("Token110");


  })
});
