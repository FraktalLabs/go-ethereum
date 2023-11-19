pragma solidity ^0.8.0;

interface SpawnTest {
  function main() external returns (string memory);
}

contract SpawnCaller {
  function main() external returns (string memory) {
    SpawnTest spawnTest = SpawnTest(address(0x4200000000000000000000000000000000000001));
    string memory retVal = spawnTest.main();
    print(retVal);
    return retVal;
  }
}
