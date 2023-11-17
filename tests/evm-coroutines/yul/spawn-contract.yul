{
  function main(printStr) {
    mstore(0x00, 0x20)
    mstore(0x20, 0x0d)
    mstore(0x40, printStr)
    
    clog(0x20)
    // revert(0x00,0x96)
  }

  let printStr := 0x48656c6c6f2c20576f726c642100000000000000000000000000000000000000
  xspawn(main(printStr))
  main(printStr)
  return(0x00, 0x96) 
}
