#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_is '10:10 11:11 12:12 10:10 11:11 12:12 '
assert_stderr_empty
