#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS_TEMPLATE=$WORK_DIR/genesis-template.json

EVM_BIN=$WORK_DIR/../../../build/bin/evm
SOL_BIN=$WORK_DIR/../../../../solidity/build/solc/solc

# Compile code
WORKER_INIT_BIN=$($SOL_BIN --bin $WORK_DIR/worker.sol | tail -n 1)
echo "Worker Init function code: $WORKER_INIT_BIN"

WORKER_BIN=$($EVM_BIN --code $WORKER_INIT_BIN run | tail -n 1)
echo "Worker code: $WORKER_BIN"

# Generate genesis json
sed -e "s|<WORKER_CODE>|$WORKER_BIN|" $GENESIS_TEMPLATE > $WORK_DIR/genesis.json
