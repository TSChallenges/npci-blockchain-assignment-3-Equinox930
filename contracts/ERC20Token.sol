// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20Token {
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 _initialSupply) {
        owner = msg.sender;
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balances[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
         require(spender != address(0), "Invalid spender address");

        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return allowances[_owner][spender];

    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balances[from] >= value, "Insufficient balance");
        require(allowances[from][msg.sender] >= value, "Allowance exceeded");
         balances[from] -= value;
        balances[to] += value;
        allowances[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(uint256 value) public {
        require(msg.sender == owner, "Only owner can mint");
        uint256 amount = value * (10 ** uint256(decimals));
        totalSupply += amount;
        balances[owner] += amount;
        emit Transfer(address(0), msg.sender, value);
        return true;    
    }

    function burn(uint256 value) public {
        uint256 amount = value * (10 ** uint256(decimals));
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), value);
        return true;
    }
}
