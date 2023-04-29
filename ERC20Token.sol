// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Token {
    string public name = "Token 1";
    string public symbol = "TK1";
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18;

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}

contract Token2 is Token {
    string public name = "Token 2";
    string public symbol = "TK2";

    constructor() {}

    function earn() public {
        uint256 reward = 1000000000000000000; // 1 token
        balanceOf[msg.sender] += reward;
    }
}

contract Token3 is Token2 {
    string public name = "Token 3";
    string public symbol = "TK3";

    constructor() {}

    function earn() public {
        uint256 reward = 100000000000000000; // 0.1 token
        balanceOf[msg.sender] += reward;
    }
}
