pragma solidity >=0.4.22 <0.7.0;


contract HelloWorld {
    
    
    function greeting() pure public returns (string memory)  {
        
        return ("Hello world");
    }
    
}

contract Hello {
    
    uint8 x;
    AddressSample addressSample;
    
    constructor () public {
        addressSample = new AddressSample();
    }
    
    function updateValue(uint8 _x) public{
        if(msg.sender != addressSample.getAddress()){
            revert();
        }
        x = _x;
    } 
    
    function addSome(uint8 _x) public {
        
        if(x+_x<x){
            revert();
        }
        
        x = x+_x;
    }
    
    function deletesome(uint8 _x) public {
        
        if(x<_x)
        {
            revert();
        }
        x = x-_x;
    }
    
    function getValue() view public returns(uint8){
        return x;
    }
}



contract AddressSample {
    
    address user = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    
    function storeAddress(address _user) public {
        
        if(msg.sender!=user){
            revert();
        }
        
        user = _user;
       
    }
    
    function getAddress() view public returns(address){
        return user;
    }
}
