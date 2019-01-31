pragma solidity >=0.4.21 <0.6.0;

contract LivePod_Token{
        string public name ="LIVEPOD TOKEN";
        string public symbol ="LVPD";
        string public standard = "LINEPOD Token v1.0";
        uint8 public decimal = 18;
        uint256 public totalSupply;

        event Transfer(address indexed _from, address indexed _to, uint256 _value);
        event Burn(address indexed _form, uint256 _value);

        mapping(address => uint256) public balanceOf;

/*    constructor() public {
            balanceOf[msg.sender] = 300000000;
        }
*/   constructor(uint256 _initialSupply) public{
      balanceOf[msg.sender]=_initialSupply;
      totalSupply=_initialSupply;
    }

   function transfer(address _to,uint256 _value) public returns(bool success){
     require(balanceOf[msg.sender]>=_value);
     balanceOf[msg.sender] -=_value;
     balanceOf[_to]+=_value;

     emit Transfer(msg.sender,_to,_value);

     return true;
   }
   function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
        balanceOf[msg.sender] -= _value;            // Subtract from the sender
        totalSupply -= _value;                      // Updates totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }
/*
    //Create New Token
 function mintToken(address target, uint256 mintedAmount) onlyOwner public {
    balanceOf[target] += mintedAmount;
    totalSupply += mintedAmount;
    emit Transfer(0, owner, mintedAmount);
    emit Transfer(owner, target, mintedAmount);
}*/
}
