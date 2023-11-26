pragma solidity ^0.8.0;

contract SpawncTest {
  function printer(string memory val) public {
    print(val);
  }

  function main() external {
    string memory val = "Spawned Hello World!";
    printer(val);
  }

  function main2(string memory val) external {
    printer(val);
  }
}
