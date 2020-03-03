pragma solidity >=0.4.22 <0.7.0;

contract Owner {
    
    address public owner;
    
    address tempOwner;
    
    constructor () public {
        owner = msg.sender;
    }
    
    modifier onlyAdmin {
        require(msg.sender==owner);
        _;
    }
    
    function changeOnwership(address _newOnwer) public onlyAdmin {
        tempOwner = _newOnwer;
    }
    
    function acceptOnwership() public {
        require(msg.sender == tempOwner);
        owner = msg.sender;
    }
}


contract Lottery is Owner {
    
    
    address payable  [] participants;
    
    uint magicNumber;
    
    mapping(address => bool) participantDetails;
    
    function joinLottery(uint _magicNumber) public payable {
        
        require(msg.value == 1 ether, "Value should  be equal to 1 ether");
        require(_magicNumber > 0, "Zero can not be a Magic Number");
        require(participantDetails[msg.sender] == false, "participant already exists");
        participants.push(msg.sender);
        participantDetails[msg.sender] = true;
        magicNumber += magicNumber;
    } 
    
    function selectWinner() public onlyAdmin  {
        
        require(participants.length>1);
        
        uint winner = ( now + block.number)%participants.length;
        
        uint winnerWithMagicNumber = (now + magicNumber)%participants.length;
        
        uint winingamount = ((participants.length*(1 ether/1 wei))*90)/100;
        
        participants[winner].transfer(winingamount);
        
        
    }
    
    function withdraw() public onlyAdmin {
        msg.sender.transfer(address(this).balance);
    }
    
}
