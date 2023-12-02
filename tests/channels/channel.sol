// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChannelTest {

  function workerFunction(uint256 val) public {
    assembly {
      mstore(0x00, val)
    }
  }

  function worker(channel msgChannel) public {
    while (true) {
      uint256 val <- msgChannel;
      workerFunction(val);
    }

    // TODO
    //uint256 val <- 0x01;
    //val <- msgChannel;
  }

  function sendMsgs(channel msgChannel, uint256 count) public {
    for (uint256 i = 1; i < count + 1; i++) {
      i -> msgChannel;
    }
  }

  function main() external {
    //TODO: also add = new channel(3)
    channel msgChannel = chancreate(3);

    spawn worker(msgChannel);

    assembly{
      mstore(0x00, msgChannel)
    }

    //channel doneChannel = chancreate(5);
    //assembly{
    //  mstore(0x00, doneChannel)
    //}
    sendMsgs(msgChannel, 6);
  }

}
