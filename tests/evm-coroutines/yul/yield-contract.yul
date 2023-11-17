{
  function main() {
    mstore(0x00, 0x20)
    mstore(0x20, 0x0d)
    mstore(0x40, 0x48656c6c6f2c20576f726c642100000000000000000000000000000000000000)

    xyield()

    clog(0x20)
    // revert(0x00,0x96)
  }

  main()
  // TODO: Why is this getting excluded when not compiled with something before return? : clog(0x20)
  //   like this : main()
  return(0x00, 0x96) 
}
