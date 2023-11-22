#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS_TEMPLATE=$WORK_DIR/genesis-template.json

EVM_BIN=$WORK_DIR/../../../build/bin/evm
SOL_BIN=$WORK_DIR/../../../../solidity/build/solc/solc

# Compile code
WORKER_BIN=$($SOL_BIN --strict-assembly --bin $WORK_DIR/worker.yul | tail -n 1)
echo "Worker function code: $WORKER_BIN"

# Generate genesis json
sed -e "s|<WORKER_CODE>|0x$WORKER_BIN|" $GENESIS_TEMPLATE > $WORK_DIR/genesis.json
