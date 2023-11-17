#!/bin/bash
#
# This script is used to run the evm caller test

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS=$WORK_DIR/genesis.json
EVM_BIN=$WORK_DIR/../../../build/bin/evm
SOL_BIN=$WORK_DIR/../../../../solidity/build/solc/solc

$SCRIPT_DIR/generate-genesis.sh

# Compile the contract
CONTRACT_BIN=$($SOL_BIN --strict-assembly --bin $WORK_DIR/yield-caller.yul | tail -n 1)
echo "Caller Contract binary: $CONTRACT_BIN"

# Run the contract
$EVM_BIN --code $CONTRACT_BIN run --prestate $GENESIS

echo "Yield caller contract done.."

# Compile the contract
SPAWN_INNER_CALLER_BIN=$($SOL_BIN --strict-assembly --bin $WORK_DIR/spawn-inner-caller.yul | tail -n 1)
echo "Spawn inner caller contract binary: $SPAWN_INNER_CALLER_BIN"

# Run the contract
$EVM_BIN --code $SPAWN_INNER_CALLER_BIN run --prestate $GENESIS

rm $GENESIS
