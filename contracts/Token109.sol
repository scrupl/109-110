pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

contract Token109 is AccessControl, ERC20, ERC20Burnable {
    constructor() public ERC20("109-110 dynamic equity token", "109") {}

    // this needs to be the bonding curve stuff, right? eh, for now it's
    // just an ERC20 contract. 
}
