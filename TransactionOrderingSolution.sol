// SPDX-License-Identifier: MIT
pragma solidity 0.5.10 ;

contract TransactionOrderingSolution{
    uint256 public precio;
    uint256 public precioIndice;
    uint256 public cantidad;
    address public owner;

    event BuyEvento(address buyer, uint256 _precio);
    event PriceChangeEvento(address _owner, uint256 _precio);

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor () public {
        owner = msg.sender;
        precio = 1;
        
        //iniciamos el indice en 0
        precioIndice = 0;
    }


    function getPrecioIndice() public view returns(uint256){
        return precioIndice;
    }
    
    function buy(uint256 _precioIndice) public payable returns(bool){
        
        //comparamos que el indice sea el mismo que en el momento que se realizó la comparamos
        require (_precioIndice == precioIndice);
        
        cantidad = msg.value/ precio;
        emit BuyEvento(msg.sender, precio);
        return true;
    }
    
    function setPrecio(uint256 _precio) public onlyOwner returns(bool){
        
        //si se cambia el precio, cambia el indice
        precio = _precio;
        precioIndice += 1;
        
        emit PriceChangeEvento(owner, precio);
        return true;
    }

}