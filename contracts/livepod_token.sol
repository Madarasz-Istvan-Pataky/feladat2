pragma solidity >=0.4.21 <0.6.0;

contract owned {
        address public owner;

        constructor() public {
            owner = msg.sender;
        }

        modifier onlyOwner {
            require(msg.sender == owner);
            _;
        }

        function transferOwnership(address newOwner) onlyOwner public {
            owner = newOwner;
        }
    }

interface tokenRecipient {
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external;
}
contract LivePod_Token is owned {
        string public name ="LIVEPOD TOKEN";
        string public symbol ="LVPD";
        string public standard = "LINEPOD Token v1.0";
        uint8 public decimal = 18;
        uint256 public totalSupply;

        event Transfer(address indexed _from, address indexed _to, uint256 _value);
        event Approval(address indexed _owner, address indexed _spender, uint256 value);
        event Burn(address indexed _form, uint256 _value);

        mapping(address => uint256) public balanceOf;
        mapping(address => mapping(address =>uint256)) public allowance;

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

     emit Transfer(msg.sender, _to, _value);

     return true;
   }
   function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
        balanceOf[msg.sender] -= _value;            // Subtract from the sender
        totalSupply -= _value;                      // Updates totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool success){
           allowance[msg.sender][_spender]=_value;
           emit Approval(msg.sender,_spender,_value);
      return true;
    }

    //Create New Token
 function mintToken(address target, uint256 mintedAmount) onlyOwner public {
    balanceOf[target] += mintedAmount;
    totalSupply += mintedAmount;
    emit Transfer(address(1), address(this), mintedAmount);
    emit Transfer(address(this), target, mintedAmount);
}
}
