pragma solidity >=0.4.22 <0.7.0;


contract Owner {
    
    address ownerAddress;
    
    address tempAdress;
    
    constructor() public{
        ownerAddress = msg.sender;
    }
    
    modifier onlyAdmin {
        require(msg.sender == ownerAddress, "Modification Can Be Done Only By Owner");
        _;
    }
    
    function changeOwner(address _newOwnerAddress) public onlyAdmin{
        tempAdress = _newOwnerAddress;
    }
    
    function validateOwner () public{
        require(tempAdress == msg.sender, "UnAuthorized Address");
        ownerAddress = msg.sender;
    }
    
}

contract Time {
    
    uint currentTime;
    
    constructor() public {
        currentTime = now;
    }
    
    function checkTime(uint _delay) view public returns(bool){
        if(now > currentTime+ _delay){
            return true;
        }
        return false;
    }
}
