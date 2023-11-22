// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Worker {
  function main(xchannel) external;
}

contract Main {
  function sendMsgs(xchannel crossChannel, uint256 cnt) public {
    string memory message = "Hello World!";

    for (uint256 i = 1; i < cnt; i++) {
      if (i == 3) {
        0x00 -> crossChannel;
      } else {
        0x20 -> crossChannel;
      }
      print(message);
    }
  }

  function main() external {
    xchannel crossChannel = xchancreate(0x03);
    Worker worker = Worker(address(0x4200000000000000000000000000000000000000));
    worker.main(crossChannel);
    sendMsgs(crossChannel, 0x06);
  }
}
