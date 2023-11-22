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
MAIN_BIN=$($SOL_BIN --strict-assembly --bin $WORK_DIR/main.yul | tail -n 1)
echo "Main : $MAIN_BIN"

# Calling caller contract
$EVM_BIN run --code $MAIN_BIN --prestate $GENESIS

echo "Main contract ran..."

rm $GENESIS
