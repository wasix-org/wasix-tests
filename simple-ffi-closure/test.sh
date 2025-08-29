#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_contains 'Closure test completed'
assert_stderr_empty
