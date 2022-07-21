import { SoulBoundFactory } from './../typechain-types/contracts/SoulBoundFactory';
import { ethers } from 'hardhat';

async function main() {
  //   const [owner1, otherAccount] = await ethers.getSigners();
  //   const others = [otherAccount.address, owner1.address];

  const owner = '0xB3910a37055df85E8EB04E12367e4DA8E24d1599';
  let admins = [
    '0xEb6CD8AB0E374f3D84a4A8006dbd90b9966A4563',
    '0xB3910a37055df85E8EB04E12367e4DA8E24d1599',
  ];

  const SoulBoundFactoryContract = await ethers.getContractFactory(
    'SoulBoundFactory'
  );
  const soulBoundFactory = await SoulBoundFactoryContract.deploy(owner, admins);
  //   const soulBoundFactory = await SoulBoundFactoryContract.deploy(
  //     owner1.address,
  //     others
  //   );

  await soulBoundFactory.deployed();

  console.log('soulBoundFactory deployed to:', soulBoundFactory.address);

  const soulBoundNFT = await soulBoundFactory.createSoulBoundContract(
    'SoulSkillOne',
    'SSO'
  );

  soulBoundNFT.wait();

  console.log('soulBoundNFT deployed to:', soulBoundNFT.data);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
