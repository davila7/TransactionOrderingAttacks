// SPDX-License-Identifier: MIT
pragma solidity 0.5.10 ;
 
 contract TransactionOrderingAttacks{
     
    uint256 public cantidad;
    uint256 public precio;
    address public owner;
   
    event BuyEvento(address buyer, uint256 _precio, uint256 _cantidad);
    event PriceChangeEvento(address _owner, uint256 _precio);
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    constructor () public{
        owner = msg.sender;
        
        //iniciamos en precio en 1 ether
        precio = 1;
    }
    
    function buy() payable public returns(uint256){
        cantidad = msg.value/precio;
        emit BuyEvento(msg.sender,precio, cantidad);
        return precio;
    }
    
    function setPrice(uint256 _precio) public onlyOwner{
        precio = _precio;
        emit PriceChangeEvento(owner, precio);
    }
}