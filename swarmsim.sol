pragma solidity ^0.8.0;

contract IdleGame {
    
    // Token definitions
    mapping(address => uint256) public token1Balances;
    mapping(address => uint256) public token2Balances;
    mapping(address => uint256) public token3Balances;
    uint256 public token1TotalSupply;
    uint256 public token2TotalSupply;
    uint256 public token3TotalSupply;
    
    // Game settings
    uint256 public blockReward = 100; // 100 units of token1 per block
    
    // Events
    event Token1Minted(address indexed to, uint256 amount);
    event Token2Minted(address indexed to, uint256 amount);
    event Token3Minted(address indexed to, uint256 amount);
    
    // Mint token2 for token1 holders
    function mintToken2() public {
        uint256 totalToken1Supply = token1TotalSupply;
        for (uint256 i = 0; i < totalToken1Supply; i++) {
            address token1Holder = token1Holders(i);
            uint256 token1Balance = token1Balances[token1Holder];
            uint256 token2MintAmount = token1Balance / 1000; // Mint 0.1% of token1 balance as token2
            token2Balances[token1Holder] += token2MintAmount;
            token2TotalSupply += token2MintAmount;
            emit Token2Minted(token1Holder, token2MintAmount);
        }
    }
    
    // Mint token3 for token2 holders
    function mintToken3() public {
        uint256 totalToken2Supply = token2TotalSupply;
        for (uint256 i = 0; i < totalToken2Supply; i++) {
            address token2Holder = token2Holders(i);
            uint256 token2Balance = token2Balances[token2Holder];
            uint256 token3MintAmount = token2Balance / 1000; // Mint 0.1% of token2 balance as token3
            token3Balances[token2Holder] += token3MintAmount;
            token3TotalSupply += token3MintAmount;
            emit Token3Minted(token2Holder, token3MintAmount);
        }
    }
    
    // Helper function to get a token1 holder by index
    function token1Holders(uint256 index) public view returns (address) {
        uint256 counter = 0;
        for (uint256 i = 0; i < token1TotalSupply; i++) {
            address holder = address(token1Balances.keys[i]);
            if (token1Balances[holder] > 0) {
                if (counter == index) {
                    return holder;
                }
                counter++;
            }
        }
        revert("Invalid token1 holder index");
    }
    
    // Helper function to get a token2 holder by index
    function token2Holders(uint256 index) public view returns (address) {
        uint256 counter = 0;
        for (uint256 i = 0; i < token2TotalSupply; i++) {
            address holder = address(token2Balances.keys[i]);
            if (token2Balances[holder] > 0) {
                if (counter == index) {
                    return holder;
                }
                counter++;
            }
        }
        revert("Invalid token2 holder index");
    }
    
    // Update the game state every block
    function update() public {
        mintToken2();
       
