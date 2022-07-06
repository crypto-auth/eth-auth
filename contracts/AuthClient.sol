//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AuthClient is ERC721URIStorage, AccessControl, Ownable {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  bytes32 public constant AGENT_ROLE = keccak256("AGENT_ROLE");

  struct ClientBasicDetails {
    address clientId;
    string redirectUri;
  }

  ClientBasicDetails clientBasicDetails;

  mapping(address => uint256) private _tokenIdByClientId;

  constructor() ERC721("AuthClient", "AUTH") {}

  // constructor(address clientAddress, string memory redirectUri) ERC721("AuthClient", "AUTH") {
  //   _grantRole(AGENT_ROLE, 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
  //   //public key / client id: 0x47007DaF4e397C78B933e660AD7E2bE09590E3Ce
  //   //secret key / client code: a72acaa1b89dbc138535c61d664ed0206bda1104032835af26935ae914ab2d66
  //   clientBasicDetails = ClientBasicDetails(clientAddress, redirectUri);
  // }

  //{privateKey: '0x8ccac74dd3294b6aff5e70359b9b9985b20c6c7412ab7132e7d6e62c2c528029', 
  // publicKey: '6e2026c3866251be48fbf2e5953895b9a3390679ff2f933661c3e20ff27bff025ace5a226223eb7cf596bf98bf24ce9ef78ca6459475421bcc4d08582fc85a3d', 
  // address: '0xc005669F2Fa6d3a436c910F0903C76038c5872Bb'}

  //encrypted_sercret_key = '5fa7ba7694c21f1eb5cdec168595137103df3fb4a7e9d3a653583a9469aebcbc4168ee342a8b861df790a2813e0825458bd1c09457c9dc437b6b4a1cf60565a62e66bd82bdcc4e0e7a3c52a59c6f1bdb6b25a36f1ddae7f287e952cf0240aa9bef17168ca647b8bd9d6b57297032a2c72a128c5793ac5f25672b6cd66470adf9ccf4ba9112858f7ea39af7cf25a402c510e32f931f076eef735bc1d9c648126732'
  //https://run.mocky.io/v3/e01cec17-ac7d-4670-8349-6e33182ab717

  function safeMint(address to, address clientId, string memory uri) public payable onlyOwner {    
    require(_tokenIdByClientId[clientId] == 0, "AuthClient: clientId already has a token");
    
    uint256 tokenId = _tokenIds.current();
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
    _tokenIdByClientId[clientId] = tokenId;
    _tokenIds.increment();
  }

  function getTokenUriByClientId(address clientId) external view onlyOwner returns(string memory) {
    uint256 tokenId = _tokenIdByClientId[clientId];
    return this.tokenURI(tokenId);
  }

  function addAddressToAgentRole(address adrs) public onlyOwner {
    _grantRole(AGENT_ROLE, adrs);
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
    return super.supportsInterface(interfaceId);
  }




}