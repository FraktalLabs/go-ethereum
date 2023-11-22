{
  function setupMemory() {
    mstore(0x00, 0x20)
    mstore(0x20, 0x0d)
    mstore(0x40, 0x58656c6c6f2c20576f726c642100000000000000000000000000000000000000)
  }

  function sendMsgs(msgChan, cnt) {
    for { let i := 1 } lt(i, cnt) { i := add(i, 0x01) } {
      if iszero(eq(i, 0x03)) { xchansend(msgChan, 0x20) }
      if eq(i, 0x03) { xchansend(msgChan, 0x00) }
      clog(0x20)
    }
  }

  function main() {
    setupMemory()
    let msgChan := xchancreate(0x03)
    mstore(0xa0, msgChan)
    let status := call(gas(), 0x4200000000000000000000000000000000000000, 0x00, 0xa0, 0x20, 0xc0, 0x00)
    // TODO: Print status
    sendMsgs(msgChan, 0x06)
  }

  main()
  return(0x00, 0x0180)
}
