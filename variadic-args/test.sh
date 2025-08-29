#!/usr/bin/env bash
source ../lib/test-utils.sh

make all
run main

assert_stdout_is "Printing 5, 6, (nil), 42"
assert_stderr_empty
assert_success
