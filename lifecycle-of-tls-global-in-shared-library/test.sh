#!/usr/bin/env bash
source ../lib/test-utils.sh

make all
run main

assert_success
assert_stdout_is "Item constructedTlsItem constructedTlsItem destructedItem destructed"
assert_stderr_empty