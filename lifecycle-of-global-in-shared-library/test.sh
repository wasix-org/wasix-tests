#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
source ../lib/assert.sh
source ../lib/test-utils.sh

make all
run main

# TLS item is not used, so it is not constructed and thus not destructed
assert_eq "Item constructedItem destructed" "$(cat stdout.log)" "destructor did not run"
assert_eq "" "$(cat stderr.log)" "stderr not empty"

