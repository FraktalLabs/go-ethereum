{
  function printNums(start, end) {
    for { let i := start } lt(i, add(end, 1)) { i := add(i, 1) }
    {
      mstore(mul(0x20, i), i)
    }
  }

  function main() {
    printNums(0x01, 0x03)
    printNums(0x0b, 0xd)
  }
}
