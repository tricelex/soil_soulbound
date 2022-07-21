// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./SoulBoundNFT.sol";

contract SoulBoundFactory is AccessControl, Ownable {
    event SoulBoundContractCreated(address soulnft);

    bytes32 public constant FACTORY_MANAGER = keccak256("FACTORY_MANAGER");

    /// @dev modifier for the factory manager role
    modifier isPermittedFactoryManager() {
        require(
            hasRole(FACTORY_MANAGER, msg.sender),
            "Not an approved factory manager"
        );
        _;
    }

    constructor(address owner, address[] memory admins) {
        for (uint256 i = 0; i < admins.length; i++) {
            _setupRole(DEFAULT_ADMIN_ROLE, admins[i]);
            _setupRole(FACTORY_MANAGER, admins[i]);
        }
        transferOwnership(owner);
    }

    function createSoulBoundContract(string memory name, string memory abbrev)
        public
        isPermittedFactoryManager
        returns (address soulNftContractAddress)
    {
        SoulBoundNFT newSoulNft = new SoulBoundNFT(name, abbrev);

        soulNftContractAddress = address(newSoulNft);

        emit SoulBoundContractCreated(soulNftContractAddress);

        return soulNftContractAddress;
    }
}
