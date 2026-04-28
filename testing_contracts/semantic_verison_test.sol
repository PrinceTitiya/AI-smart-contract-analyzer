// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
   function withdrawAlt(uint amount) public {
    require(balances[msg.sender] >= amount);

    (bool ok,) = payable(msg.sender).call{value: amount}("");
    require(ok);

    balances[msg.sender] -= amount;
}
}
