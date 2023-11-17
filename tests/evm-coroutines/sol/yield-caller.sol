pragma solidity ^0.8.0;

interface YieldTest {
  function main() external returns (string memory);
}

contract YieldCaller {
  function main() external returns (string memory) {
    YieldTest yieldTest = YieldTest(address(0x4200000000000000000000000000000000000000));
    string memory retVal = yieldTest.main();
    print(retVal);
    return retVal;
  }
}
