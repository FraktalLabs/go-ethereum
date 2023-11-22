#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS=$WORK_DIR/genesis.json
EVM_BIN=$WORK_DIR/../../../build/bin/evm
SOL_BIN=$WORK_DIR/../../../../solidity/build/solc/solc

$SCRIPT_DIR/generate-genesis.sh

# Compile code
echo "Compiling main.sol..."
echo "===================="
$SOL_BIN --bin $WORK_DIR/main.sol
echo "===================="
MAIN_INIT_BIN=$($SOL_BIN --bin $WORK_DIR/main.sol | grep main.sol:Main -A 2 | tail -n 1)
echo "Main Init : $MAIN_INIT_BIN"

MAIN_BIN=$($EVM_BIN --code $MAIN_INIT_BIN run | tail -n 1)
echo "Main : $MAIN_BIN"

# Calling caller contract
$EVM_BIN run --code $MAIN_BIN --prestate $GENESIS --input 0xdffeadd0

echo "Main contract ran..."

rm $GENESIS
