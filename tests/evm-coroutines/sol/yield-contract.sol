pragma solidity ^0.8.0;

contract YieldTest {
  function main() external returns (string memory) {
    string memory val = "Hello World!";
    print(val);
    xyield();
    return val;
  }
}
