#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_is "other_func is not defined, but the program still compiled"
assert_stderr_empty
