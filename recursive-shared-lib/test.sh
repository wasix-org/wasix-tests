#!/usr/bin/env bash
source ../lib/test-utils.sh

make all
run main

assert_success
assert_stdout_is "The shared library returned: 42"
assert_stderr_empty