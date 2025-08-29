#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_is "abcdef"
assert_stderr_empty