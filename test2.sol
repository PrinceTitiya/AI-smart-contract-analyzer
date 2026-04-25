// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableBank {
    mapping(address => uint256) public balances;
    uint256 public lastWithdrawTime;

    // Deposit Ether into the contract
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }


    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");


        require(block.timestamp >= lastWithdrawTime + 1 minutes, "Wait before withdrawing again");

        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] -= _amount;
        lastWithdrawTime = block.timestamp;
    }

    // Helper to check contract balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}