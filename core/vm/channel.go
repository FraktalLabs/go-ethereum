package vm

import (
	"github.com/holiman/uint256"
)

type ChanSend struct {
  Value uint256.Int
  Coroutine Coroutine
}

//TODO: Use references where possible
type Channel struct {
  Buffer []uint256.Int
  BufferSize uint64

  ReceiveQueue []Coroutine
  ReceiveQueueSize uint64

  SendQueue []ChanSend
  SendQueueSize uint64
}

type XChanSend struct {
  Value uint256.Int
  EVMCoroutine EVMCoroutine
}

type XChannel struct {
  Buffer []uint256.Int
  BufferSize uint64

  ReceiveQueue []EVMCoroutine
  ReceiveQueueSize uint64

  SendQueue []XChanSend
  SendQueueSize uint64
}

func NewChannel(bufferSize uint64, receiveQueueSize uint64, sendQueueSize uint64) Channel {
  return Channel{
    Buffer: make([]uint256.Int, 0),
    BufferSize: bufferSize,
    ReceiveQueue: make([]Coroutine, 0),
    ReceiveQueueSize: receiveQueueSize,
    SendQueue: make([]ChanSend, 0),
    SendQueueSize: sendQueueSize,
  }
}

func NewXChannel(bufferSize uint64, receiveQueueSize uint64, sendQueueSize uint64) XChannel {
  return XChannel{
    Buffer: make([]uint256.Int, 0),
    BufferSize: bufferSize,
    ReceiveQueue: make([]EVMCoroutine, 0),
    ReceiveQueueSize: receiveQueueSize,
    SendQueue: make([]XChanSend, 0),
    SendQueueSize: sendQueueSize,
  }
}
