#!/usr/bin/env bash
source ../lib/test-utils.sh

make all
run main

assert_success
assert_stdout_not_empty
assert_stderr_empty