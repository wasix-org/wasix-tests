#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_is 'Item constructedTlsItem constructedTlsItem destructedItem destructed'
assert_stderr_empty
