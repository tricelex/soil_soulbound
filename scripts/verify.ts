import { ethers } from 'hardhat';
const hre = require('hardhat');

async function main() {
  const owner = '0xB3910a37055df85E8EB04E12367e4DA8E24d1599';
  let admins = [
    '0xEb6CD8AB0E374f3D84a4A8006dbd90b9966A4563',
    '0xB3910a37055df85E8EB04E12367e4DA8E24d1599',
  ];

  const name = 'SoulSkillOne';
  const abbrev = 'SSO';

  // await hre.run('verify:verify', {
  //   address: '0xDD57846c9D4D263c582868Fc54fb55E1E59A6bd6',
  //   constructorArguments: [owner, admins],
  // });

  await hre.run('verify:verify', {
    address: '0xEdEe5fe2324C59eb104e7824292D908BA03289BE',
    constructorArguments: [name, abbrev],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
