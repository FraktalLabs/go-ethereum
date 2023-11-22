{
  function workerFunc(pos) {
    clog(pos)
  }

  function workerLoop(msgChan) {
    let i := 0
    for { } lt(i, 0x100) { } {
      let value := xchanrecv(msgChan)
      workerFunc(value)
    }
  }

  function setupMemory() {
    mstore(0x00, 0x20)
    mstore(0x20, 0x0d)
    mstore(0x40, 0x48656c6c6f2c20576f726c642100000000000000000000000000000000000000)
  }

  function main() {
    setupMemory()
    let msgChan := calldataload(0x00)
    xspawn(workerLoop(msgChan))
  }

  main()
}
