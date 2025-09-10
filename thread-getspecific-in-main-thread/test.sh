#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_contains 'thread_getspecific returned: 0x'
assert_stderr_empty
