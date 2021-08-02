pragma solidity ^0.8.0;

contract CryptoBank{
    
    address owner;
    uint8 count;
// STEP4 
    mapping (address => uint) accounts;
    constructor() payable {
        owner = msg.sender;
        require(msg.value >= 50 ether,"please deposits at least 50 ethers.");
        count = 0;
    }

// STEP2 : only the owner can close the bank. upon closing the balance should return to the owner.

function closeBank() public payable {
    
    require(msg.sender == owner, "only owner can close the bank");
        selfdestruct(payable(owner));
    }

// STEP3 : anyone can open an account in the bank for account opening they need to deposit ether with address.

function openAccount() public payable {
    
    require(msg.value > 0 && msg.sender != address(0), "Value should not be 0 or invalid address");
    accounts[msg.sender] = msg.value;
    
    if(count <=4) {
        accounts[msg.sender] += 1 ether;
        count++;
    }
    
 }
    
// STEP5 : anyone can deposit in the bank.  

function deposit(address _addr, uint _amount) public payable{
    
     require(msg.value > 0 && msg.sender != address(0), "Value should not be 0 or invalid address");
    accounts[_addr] += _amount;
    }

// STEP6 : only valid account holders can withdraw.

function withDraw(uint _amount) public payable{
     require(msg.value > 0 && msg.sender != address(0), "Value should not be 0 or invalid address");
     require(_amount <= accounts[msg.sender], "invalid bank account");
     payable(msg.sender).transfer(_amount);
     accounts[msg.sender] -= _amount;
    }

// STEP8 : account holder can inquiry balance. the depositor can request for closing an account.

    function inquireBalance() public view returns(uint){
    return accounts[msg.sender];
    }
    
    function closeAccount() public {
       require(msg.sender != address(0) && accounts[msg.sender] > 0 , "Value should not be 0 or invalid address");  
       payable(msg.sender).transfer(accounts[msg.sender]);
     
    }
    
    function bankTotalBalance() public view returns(uint){
        require(msg.sender == owner, "only the owner can view the bank balance");
        return address(this).balance;
    }
}







