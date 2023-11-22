// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Worker {
  function workerLoop(xchannel crossChannel) public {
    string memory message = "Hello from worker";
    print(message);

    while (true) {
      uint256 val <- crossChannel;
      assembly {
        mstore(0x44, val)
      }
      print(message);
    }
  }

  function main(xchannel crossChannel) external {
    xspawn workerLoop(crossChannel);
  }
}
