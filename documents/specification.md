# Specification for 109-110 contracts

## Token 110
The token110 is equivalent to the *shareholder register* in the 109-110 constitution, meaning the token contract keeps a record of all legal shareholders to 109-110 Company Limited.

Token110 conforms to the [ERC-721 Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721), which means that an ownership deed should be recognizable by any wallet that supports ERC721 NFTs.

Token110 includes optional extensions in the [OpenZeppelin contract libraries](https://docs.openzeppelin.com/contracts/3.x/api/token/erc721), i.e. its interface is described by `IERC721`, `IERC721Metadata`, and `IERC721Enumerable`.


### Access Control
In keeping with 109-110's vision of bi-directional coupling between smart contract and legal entity, `token110` has pre-defined "roles" which correspond to those positions described in [the 109-110 constitution](./constitution.md).

`DIRECTOR` - A role that can only be granted to a registered director of 109-110 Company Limited
`MEMBER` - A role that is by default granted to any new shareholder upon the creation of their shareholder deed. 



### Functions
```

```
