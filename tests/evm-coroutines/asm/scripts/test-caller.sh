#!/bin/bash
#
# Compile code and generate genesis json from template

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"   
WORK_DIR=$SCRIPT_DIR/..

GENESIS=$WORK_DIR/genesis.json
EVM_BIN=$WORK_DIR/../../../build/bin/evm

$SCRIPT_DIR/generate-genesis.sh

# Compile code
YIELD_CALLER=$($EVM_BIN compile $WORK_DIR/caller-yield.txt)
echo "Caller : $YIELD_CALLER"

# Calling caller contract
$EVM_BIN run --code $YIELD_CALLER --prestate $GENESIS

echo "Yield caller contract ran..."

SPAWN_INNER_CALLER=$($EVM_BIN compile $WORK_DIR/caller-inner-spawn.txt)
echo "Spawn inner caller : $SPAWN_INNER_CALLER"

# Calling caller contract
$EVM_BIN run --code $SPAWN_INNER_CALLER --prestate $GENESIS

echo "Spawn inner caller contract ran..."

SPAWNC_INNER_CALLER=$($EVM_BIN compile $WORK_DIR/caller-spawnc.txt)
echo "Spawnc inner caller : $SPAWNC_INNER_CALLER"

# Calling caller contract
$EVM_BIN run --code $SPAWNC_INNER_CALLER --prestate $GENESIS

echo "Spawn inner caller contract ran..."

rm $GENESIS
