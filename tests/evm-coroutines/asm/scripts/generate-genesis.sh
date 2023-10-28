#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS_TEMPLATE=$WORK_DIR/genesis-template.json

EVM_BIN=$WORK_DIR/../../../build/bin/evm

# Compile code
YIELD_BIN=$($EVM_BIN compile $WORK_DIR/yield-func.txt)
echo "Yield function code: $YIELD_BIN"

# Generate genesis json
sed -e "s|<YIELD_FUNC_CODE>|0x$YIELD_BIN|" $GENESIS_TEMPLATE > $WORK_DIR/genesis.json
