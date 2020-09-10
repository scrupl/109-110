pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Token110 is AccessControl, ERC721 {

    constructor(address founder1, address founder2) public ERC721("109-110 Company Ltd Shareholder deeds", "110") {
        grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        grantRole(DIRECTOR, founder1);
        grantRole(MEMBER, founder1);
        grantRole(DIRECTOR, founder2);
        grantRole(MEMBER, founder2);
        _setRoleAdmin(MEMBER, DIRECTOR);
    }

    /**
    * For now, 109-110 doesn't need anything but DIRECTOR roles, but for testing
    * I'm including the MEMBER role, which would be able to renounce (burn)
    * their own membership, transfer to other (self-owned) addresses,
    * but not to change other member's roles or alter
    */

    bytes32 public constant DIRECTOR = keccak256("DIRECTOR");
    bytes32 public constant MEMBER = keccak256("MEMBER");

    /*
    * This document attachment scheme is from a reference implementation for
    * ERC-1462. The contract itself may be used to register any document for
    * 109-110, but to mint an ownership token (110), the attached document
    * must contain the necessary KYC for sharholders as described in the
    * constitution.
    */

    struct Document {
        bytes32 name;
        string uri;
        bytes32 contentHash;
    }

    mapping (bytes32 => Document) private documents;

    function attachDocument(bytes32 _name, string memory _uri, bytes32 _contentHash) public {
        require(hasRole(MEMBER, msg.sender), "document submitter must be a member");
        require(_name.length > 0, "name of the document must not be empty");
        require(bytes(_uri).length > 0, "external URI to the document must not be empty");
        require(_contentHash.length > 0, "content hash is required, use SHA3 when in doubt");
        require(documents[_name].name.length == 0, "document must not be existing under the same name");
        documents[_name] = Document(_name, _uri, _contentHash);
    }

    function lookupDocument(bytes32 _name) external view returns (string memory, bytes32) {
        Document storage doc = documents[_name];
        return (doc.uri, doc.contentHash);
    }

    /**
    * This section describes the functions that allow people to join or exit
    * 109-110 as a shareholder.
    */

    /**
    * A new MEMBER can be appointed by a DIRECTOR.
    * The DIRECTOR that appoints the member is automatically approved to
    * move or manipulate the token on the member's behalf (as precaution).
    */
    function newMember(address _member, uint256 _tokenId, bytes32 _name, string memory _uri, bytes32 _contentHash) public {
        require(hasRole(DIRECTOR, msg.sender), "Only a DIRECTOR can do this");
        attachDocument(_name, _uri, _contentHash);
        grantRole(MEMBER, _member);
        _safeMint(_member, _tokenId);
        approve(msg.sender, _tokenId);
    }

    function rageQuit(uint256 tokenId) external {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }
}
