pragma solidity ^0.8.0;

contract SpawnTest {
  function printer(string memory val) public {
    print(val);
  }

  function main() external returns (string memory) {
    string memory val = "Hello World!";
    string memory val2 = "Hello World 2!";
    xspawn printer(val2);
    printer(val);
    return val;
  }
}
