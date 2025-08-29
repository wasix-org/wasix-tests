#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_is 'value=10 value=11 value=10 value=12 '
assert_stderr_empty
