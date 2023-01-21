pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "./SolidityBaseball.sol";

contract SBTeams is ERC721 {
    // Define the struct for a team's NFT
    struct TeamNFT {
        address owner;
        string name;
        address[] players;
    }

    // Define the mapping for the NFTs
    mapping (uint256 => TeamNFT) public tokens;

    // Define the event that will be emitted when a new NFT is minted
    event Mint(address indexed to, uint256 tokenId);

    // Define the event that will be emitted when an NFT is transferred
    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    // Define the SolidityBaseball contract as a variable
    SolidityBaseball public baseball;

    // Define a variable to check if NFT transfers are allowed
    bool public transferEnabled;

    // Define the admin address
    address public admin;

    // Define the function to mint a new NFT
    function mint(address _owner, string memory _name, address _baseball) public {
        // Get the next token ID
        uint256 tokenId = tokens.length;

        // Assign the baseball contract address
        baseball = SolidityBaseball(_baseball);

        // Get the players that were drafted to the team
        address[] memory players = baseball.getDraftedPlayers(_owner);

        // Assign the owner, name and players to the NFT
        tokens[tokenId].owner = _owner;
        tokens[tokenId].name = _name;
        tokens[tokenId].players = players;

        // Assign the token ID to the owner
        _mint(_owner, tokenId);

        // Emit the Mint event
        emit Mint(_owner, tokenId);
    }

    // Define the function to update the players on an NFT
    function updatePlayers(uint256 _tokenId, address _baseball) public {
        // Get the address of the msg.sender
        address msgSender = msg.sender;

        // Check that the msg.sender is the owner of the token or the admin
        require(ownerOf(_tokenId) == msgSender || msgSender == admin, "You are not the owner of this token or admin");

        // Assign the baseball contract address
        baseball = SolidityBaseball(_baseball);

        // Get the players that were drafted to the team
        address[] memory players = baseball.getDraftedPlayers(tokens[_tokenId].owner);

        // Update the players on the NFT
        tokens[_tokenId].players = players;
    }

    // Define the function to transfer ownership of an NFT
    function transfer(address _to, uint256 _tokenId) public {
        // Get the address of the msg.sender
        address msgSender = msg.sender;

        // Check that the msg.sender is the owner of the token
        require(ownerOf(_tokenId) == msgSender, "You are not the owner of this token");

        // Check if transfers are enabled
        require(transferEnabled, "Transfers are not enabled for this league");

        // Transfer the NFT
        _transfer(_to, _tokenId);

        // Update the owner of the NFT
        tokens[_tokenId].owner = _to;

        // Emit the Transfer event
        emit Transfer(msgSender, _to, _tokenId);
    }

    // Define the function to turn transfers on/off
    function setTransferEnabled(bool _enabled) public {
        // Check that the msg.sender is the admin
        require(msg.sender == admin, "You are not the admin of this league");

        // Update the transferEnabled variable
        transferEnabled = _enabled;
    }
    // Define the function that assigns the admin address
    function setAdmin(address _admin) public{
        require(msg.sender == _admin, "You are not the admin of this league");
        admin = _admin;
    }
}

