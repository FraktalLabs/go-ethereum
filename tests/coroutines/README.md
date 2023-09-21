# Coroutines EVM tests

## How to Run :

1. Build `evm` commandline tool using `make all` at `go-ethereum/`
2. Run the following command to execute a contract to test Coroutines using the Spawn & Yield opcodes.
```
evm --code 603d565b805b60018301811015602157808160200252fc5b6001810190506005565b505050565b6043600360016003fb5050603b6010600b6003565b565b60436026565b6103006020f3 run
```
3. Inspect Output, should see something like :
```
2023/09/20 21:42:59 opMstore: mStart=[352 0 0 0], val=[11 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[32 0 0 0], val=[1 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[384 0 0 0], val=[12 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[64 0 0 0], val=[2 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[416 0 0 0], val=[13 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[96 0 0 0], val=[3 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[448 0 0 0], val=[14 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[480 0 0 0], val=[15 0 0 0]
2023/09/20 21:42:59 opMstore: mStart=[512 0 0 0], val=[16 0 0 0]

```

### What is this doing?

Essentially running this code in the EVM ( modified `printNumbers.yul` ) :

```
{
  function printNums(start, end) {
    for { let i := start } lt(i, add(end, 1)) { i := add(i, 1) }
    {
      mstore(mul(0x20, i), i)
      yield
    }
  }

  function main() {
    spawn printNums(0x01, 0x03)
    printNums(0x0b, 0xd)
  }

  return main()
}
```

**Useful Links**
- Using printNumbers function referenced in this article on building a language with coroutines : https://abhinavsarkar.net/posts/implementing-co-3/
- View EVM bytecode more easily : https://ethervm.io/decompile
- Decode Strings from Memory : https://dencode.com/en/string
- Opcodes : https://ethereum.org/en/developers/docs/evm/opcodes/


1. Compiling `printNumbers.yul` with `solc --strict-assembly printNumbers.yul` gives the contract bytecode `603b565b805b600183018110156020578081602002525b6001810190506005565b505050565b602f600360016003565b6039600d600b6003565b565b`

2. After manually adding some EVM codes to the end to call `main()` and return the values set in memory we get `603b565b805b600183018110156020578081602002525b6001810190506005565b505050565b602f600360016003565b6039600d600b6003565b565b60416025565b6103006020f3`

3. Finally we make the following changes:
  - Change the call `printNums(0x01, 0x03)` to `spawn printNums(0x01, 0x03)`
    - Changing JUMP instruction(s) to SPAWN instruction fb
    - Adding POP(s) after SPAWN instruction to pop arguments off of stack
    - Change function JUMPs return destination to EOP ( end of program ) to save jump dest into SPAWNed coroutine
  - Add a YIELD statement after `mstore(mul(0x20, i), i)` inside the for loop in `printNums(start, end)`
    - Add The YIELD opcode fc after MSTORE
    - This makes it so you need to shift most JUMP destination POP values due to inserting new code

4. Once done, you get the following bytecode contract ! 

```
603d565b805b60018301811015602157808160200252fc5b6001810190506005565b505050565b6043600360016003fb5050603b6010600b6003565b565b60436026565b6103006020f3
```

## Other Test Contracts

1. Run `yields.yul`, using a similar process as above to add a YIELD statment between the 2 `Mstore`s
```
evm --code 6018565b6042608052fc603260a052565b60166003565b565b601e6010565b60406080f3 run
```

Output :
```
2023/09/20 22:52:55 opMstore: mStart=[128 0 0 0], val=[66 0 0 0]
2023/09/20 22:52:55 opMstore: mStart=[160 0 0 0], val=[50 0 0 0]
```

2. Run `functions.yul`, using a similar process as above to change the `basic()` call in `main()` to `spawn basic()`.
```
evm --code 6030565b6042608052565b8060a05250565b81810160c0528260e052505050565b60366003fb50602e6032600a565b565b60366020565b60406080f3 run
```

Output :
```
2023/09/20 22:54:58 opMstore: mStart=[160 0 0 0], val=[50 0 0 0]
2023/09/20 22:54:58 opMstore: mStart=[128 0 0 0], val=[66 0 0 0]
0x00000000000000000000000000000000000000000000000000000000000000420000000000000000000000000000000000000000000000000000000000000032
```

3. Run `functions.yul` calling `basic` and `func1` respectively :
- 6028565b6042608052565b8060a05250565b81810160c0528260e052505050565b60266003565b565b602e6020565b60206080f3
- 602a565b6042608052565b8060a05250565b81810160c0528260e052505050565b60286032600a565b565b60306020565b602060a0f3


## TODO
- Return values not printing once determined only by coroutine queue execution
- Remove the `ExecuteCoroutine` from yield, and only set a flag that one is ready to run. Allow the Interpreter to execute the coroutines in queue to prevent call stack building up.
