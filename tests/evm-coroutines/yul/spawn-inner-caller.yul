{
  function setupMemory() {
    // Setting up memory for logging
    mstore(0x0140, 0x4F) // Store O for success flag at 0x00
    mstore(0x0160, 0x46) // Store F for fail flag at 0x20
  }

  function printStatus(status) {
    mstore(0x00, 0x20)
    mstore(0x20, 0x20)
    if eq(status, 0x01) {
      mstore(0x40, mload(0x0140))
    }
    if eq(status, 0x00) {
      mstore(0x40, mload(0x0160))
    }
    clog(0x20)
    mstore(0x40, 0x00)
  }

  function callYieldContract() -> status {
    status := call(gas(), 0x4200000000000000000000000000000000000001, 0x00, 0x80, 0x20, 0xa0, 0x00)
  }

  function main() {
    setupMemory()

    let status := callYieldContract()
    printStatus(status)

    returndatacopy(0x00, 0x00, returndatasize())
    clog(0x20)
  }

  main()
  return(0x00, 0x0180)
}
