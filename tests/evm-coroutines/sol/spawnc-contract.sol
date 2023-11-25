pragma solidity ^0.8.0;

contract SpawncTest {
  function printer(string memory val) public {
    print(val);
  }

  function main() external {
    string memory val = "Spawned Hello World!";
    printer(val);
  }
}
