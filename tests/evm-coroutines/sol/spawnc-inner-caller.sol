pragma solidity ^0.8.0;

interface SpawncTest {
  function main() external;
}

contract SpawnCaller {
  function main() external returns (string memory) {
    SpawncTest spawnTest = SpawncTest(address(0x4200000000000000000000000000000000000002));
    xspawncall spawnTest.main();
    //spawnTest.main();

    string memory message = "SpawnCaller.main() called SpawnTest.main()";
    print(message);
    return "SpawnCaller.main()";
  }
}
