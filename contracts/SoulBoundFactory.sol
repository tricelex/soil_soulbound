// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./SoulBoundNFT.sol";

contract SoulBoundFactory is AccessControl, Ownable {
    mapping(string => SoulBoundNFT) soulBound;
    string[] soulBoundSymbols;

    mapping(string => address) public deployedAddress;

    SoulBoundNFT[] public soulBoundNFTs;

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

    function createSoulBoundContract(string memory _name, string memory _symbol)
        public
        isPermittedFactoryManager
        returns (address soulNftContractAddress)
    {
        SoulBoundNFT newSoulNft = new SoulBoundNFT(_name, _symbol);

        soulNftContractAddress = address(newSoulNft);

        soulBound[_symbol] = newSoulNft;
        soulBoundNFTs.push(newSoulNft);

        deployedAddress[_name] = soulNftContractAddress;

        emit SoulBoundContractCreated(soulNftContractAddress);
    }

    function getSoulBoundNFTSymbolsArrayLength() public view returns (uint256) {
        return soulBoundSymbols.length;
    }

    function getSoulBoundNFTSymbolByIndex(uint256 _index)
        public
        view
        returns (string memory)
    {
        return soulBoundSymbols[_index];
    }

    function getSoulBoundNFTAddressBySymbol(string memory _symbol)
        public
        view
        returns (address)
    {
        return address(soulBound[_symbol]);
    }

    function getDeployedSoulBoundContracts()
        public
        view
        returns (SoulBoundNFT[] memory soulNftContractAddresses)
    {
        soulNftContractAddresses = new SoulBoundNFT[](
            soulNftContractAddresses.length
        );
        uint256 count;

        for (uint256 i = 0; i < soulNftContractAddresses.length; i++) {
            soulNftContractAddresses[count] = soulNftContractAddresses[i];
            count++;
        }
    }

    /// @notice Adds a new Factory Manager
    /// @param _newFactoryManager the address of the person you are adding
    function addFactoryManager(address _newFactoryManager) public onlyOwner {
        grantRole(FACTORY_MANAGER, _newFactoryManager);
    }
}
