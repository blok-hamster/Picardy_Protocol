// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PicardyArtisteToken is ERC20, Ownable {

    uint constant productId = 2;

    address public creator;
    uint public maxSupply;
    uint private txFee;
    constructor(uint _maxSupply, string memory _name, string memory _symbol, address _creator) ERC20(_name, _symbol){
        maxSupply = _maxSupply;
        creator = _creator;

        _mint(_creator, _maxSupply);
        transferOwnership(creator);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        address TX_FEE = address(0);
        
        uint TxFee = (5 / amount) * 100;
        uint ToTransfer = amount - TxFee;
        txFee +=TxFee;
        super.transfer(to, ToTransfer);
        super.transfer(TX_FEE, TxFee);
        return true;
    }

}