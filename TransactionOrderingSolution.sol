pragma solidity 0.5.10 ;

contract solutionTransactionOrdering{
    uint256 public price;
    uint256 public priceChangeIndex;
    uint256 public PurchaseQuantity;
    address public Owner;

    event BuyEv(address buyer, uint256 _Price);
    event PriceChangeEv(address _owner, uint256 _Price);

modifier onlyowner(){
    require(msg.sender == Owner);
    _;
}

constructor()public {
    Owner = msg.sender;
    Price = 5;
    PriceChangeIndex = 0;
    }


    function getPriceChangeIndex() public view returns(uint256){
        return PriceChangeIndex;
    }
    
    function buy(uint256 _PriceChangeIndex) public payable returns(bool){
        require (_PriceChangeIndex == PriceChangeIndex);
        PurchaseQuantity = msg.value/ Price;
        emit BuyEv(msg.sender, Price);
        return true;
    }
    
    function setPrice(uint256 _Price) public onlyowner returns(bool){
        Price = _Price;
        PriceChangeIndex += 1 ;
        emit PriceChangeEv(Owner, Price);
        return true;
    }

}