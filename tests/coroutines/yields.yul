{
  // TODO: return vals, storage
  function basic() {
    mstore(0x80, 0x42)
    mstore(0xa0, 0x32)
  }

  function main() {
    basic()
  }
}
