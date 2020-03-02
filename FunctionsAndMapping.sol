pragma solidity >=0.4.22 <0.7.0;


contract Students {
    
    
    struct Student {
        address stdAddress;
        uint8   rollno;
        uint8   percentage;
    }
    address public teacher;
    Student  std1;
    
    mapping (address => Student) studentDetails;
    
    mapping (address => mapping(uint8 => bool)) public attendance;
    
    mapping(address => bool) multiTeachers;
    
    constructor() public {
       
       teacher = msg.sender;
      // studentDetails[0xdD870fA1b7C4700F2BD7f44238821C26f7392148] = Student(0xdD870fA1b7C4700F2BD7f44238821C26f7392148,90,98); 
    }
    

    function setMultipleTeachersAsAdmins(address _newTeacherAddress) public {
        if(msg.sender != teacher){
            revert();
        }
        multiTeachers[_newTeacherAddress] = true;
    }
    
    function removeTeacherAsAdmin(address _newTeacherAddress) public {
       if(teacher != msg.sender) {
           revert();
       }
       multiTeachers[_newTeacherAddress] = false;

   }
   
   function isTeacherAdmin(address _teacherAddress) view public returns (bool) {
       return multiTeachers[_teacherAddress];
   }
    
   //wirte a method to change the address teacher value, this new method should accept an address and it can only be called by current teacher.
   function setNewTeacher(address _newTeacherAddress) public {
       if(teacher != msg.sender){
           revert();
       }
       teacher = _newTeacherAddress;
   }
   

   
   //add new method to update student details. this can be done by student himself or teacher.
   
   function updateStudentDetails(address _stdAddress, uint8 _rollno, uint8 _percentage) public {
       Student memory student = studentDetails[_stdAddress];
       if( !multiTeachers[msg.sender] && msg.sender != _stdAddress ){
           revert();
       }
       if(student.stdAddress == address(0)){
           addStudentDetails(_stdAddress,_rollno,_percentage);
       } 
       else {
           studentDetails[_stdAddress].rollno = _rollno;
           studentDetails[_stdAddress].percentage = _percentage;
       }
       
   }
   
   
    function setAttendance(address _stdAddress,uint8 _classno) public {
        if(teacher != msg.sender){
           revert();
       }
        attendance[_stdAddress][_classno] = true;
    }
    
    // function getAttendance (address _stdAddress,uint8 _classno) view public returns (bool){
    //     return attendance[_stdAddress][_classno];
    // }
    
    function addStudentDetails(address _stdAddress,uint8 _rollno,uint8 _percentage) public {
        if(teacher != msg.sender){
           revert();
       }
        
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
}
