#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS_TEMPLATE=$WORK_DIR/genesis-template.json

EVM_BIN=$WORK_DIR/../../../build/bin/evm
SOL_BIN=$WORK_DIR/../../../../solidity/build/solc/solc

# Compile code
YIELD_BIN=$($SOL_BIN --strict-assembly --bin $WORK_DIR/yield-contract.yul | tail -n 1)
echo "Yield contract code: $YIELD_BIN"

SPAWN_BIN=$($SOL_BIN --strict-assembly --bin $WORK_DIR/spawn-contract.yul | tail -n 1)
echo "Spawn contract code: $SPAWN_BIN"

# Generate genesis json
sed -e "s|<YIELD_CONTRACT_CODE>|0x$YIELD_BIN|" $GENESIS_TEMPLATE > $WORK_DIR/genesis.json
sed -i -e "s|<SPAWN_CONTRACT_CODE>|0x$SPAWN_BIN|" $WORK_DIR/genesis.json
