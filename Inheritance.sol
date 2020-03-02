pragma solidity >=0.4.22 <0.7.0;


import "./owner.sol";



 contract Base is Owner {
    
    struct Student {
        address stdAddress;
        uint8   rollno;
        uint8   percentage;
        mapping (string=>string) stringValues;
        mapping (string=>uint)  intValues;
    }
    address public teacher;
    Student  std1;
    
    mapping (address => Student) studentDetails;
    
    mapping (address => mapping(uint8 => bool)) public attendance;
    
   
    
    function addStudentDetails(address _stdAddress,uint8 _rollno,uint8 _percentage) public {
        
        
        Student memory temp = studentDetails[_stdAddress];
        
        if(temp.stdAddress != address(0)){
            revert();
        }
        
        studentDetails[_stdAddress] = Student(_stdAddress,_rollno,_percentage);
    }
    
    function getStudentDetails(address _stdAddress) view  public returns (address,uint8,uint8)  {
        
        if(msg.sender != teacher && msg.sender != _stdAddress){
            revert();
        }
        
        return (studentDetails[_stdAddress].stdAddress,studentDetails[_stdAddress].rollno,studentDetails[_stdAddress].percentage);
    }
    
    
   // function updateSomething(string memory _something,uint _somevalue) virtual public; -- abstract method
    
}


contract Class1 is Base {
    
    
      function selfRegister(address _stdAddress,uint8 _rollno,uint8 _percentage) public payable {
        
        if(msg.value == 1 ether){
            revert();
        }
        
        
         Student memory temp = studentDetails[_stdAddress];
        
        if(temp.stdAddress == address(0)){
           // studentDetails[_stdAddress] = Student(_stdAddress,_rollno,_percentage);
           addStudentDetails(_stdAddress,_rollno,_percentage);
        }
    }
    // function updateSomething(string memory _something,uint _somevalue) override public{
        // abstract method implementation
    // }
}


contract Exam is Base,Time {
    
    function updateMarks(string memory _examName,uint8 _marks,address _stdAddress) public onlyAdmin {
        
        require(checkTime(20));
        
        
       // Student memory temp = studentDetails[_stdAddress];
       // temp.percentage = _marks;
        //studentDetails[_stdAddress] = temp;
        
        studentDetails[_stdAddress].intValues[_examName] = _marks;
        
        
    }
    
    function getMarks(string memory _examName,address _stdAddress) public view returns(uint){
        
        return studentDetails[_stdAddress].intValues[_examName];
    }
    
   // function updateSomething(string memory _something,uint _somevalue) override public{
        // abstract method implementation
    // }
    
}


contract StudentInfo is Base {
    function addStudentAdditionalInformation(address _stdAddress, string memory _phoneNumber, string memory _emailAddress) public{
        studentDetails[_stdAddress].stringValues['PhoneNumber'] = _phoneNumber;
        studentDetails[_stdAddress].stringValues['Email'] = _emailAddress;
    }
    
    
     function getStudentAdditionalInformation(address _stdAddress) view public returns(string memory, string memory){
         
        return(studentDetails[_stdAddress].stringValues['PhoneNumber'], studentDetails[_stdAddress].stringValues['Email']);
    }
    
   // function updateSomething(string memory _something,uint _somevalue) override public{
        // abstract method implementation
    // }
}
