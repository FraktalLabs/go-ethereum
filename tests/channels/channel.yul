{
  function workerFunc(val) {
    mstore(0x00, val)
  }

  function worker(msgChan) {
    let i := 0
    for { } lt(i, 0x100) { } {
      let value := chanrecv(msgChan)
      workerFunc(value)
    }
  }

  function sendMsgs(msgChan, cnt) {
    for { let i := 1 } lt(i, cnt) { i := add(i, 0x01) } {
      chansend(msgChan, i)
    }
  }

  function main() {
    let msgChannel := chancreate(0x03)
    spawn(worker(msgChannel))
    sendMsgs(msgChannel, 0x06)
  }

  main()
  return(0x00, 0x20)
}
