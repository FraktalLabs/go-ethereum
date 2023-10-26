#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS=$WORK_DIR/genesis.json
EVM_BIN=$WORK_DIR/../../../build/bin/evm

$SCRIPT_DIR/generate-genesis.sh

# Compile code
CALLER=$($EVM_BIN compile $WORK_DIR/caller.txt)
echo "Caller : $CALLER"

# Calling contract
$EVM_BIN run --code $CALLER --prestate $GENESIS

rm $GENESIS
