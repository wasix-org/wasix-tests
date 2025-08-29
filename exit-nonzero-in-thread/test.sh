#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_exit_code 99
assert_stdout_is "Thread called!"
assert_stderr_empty