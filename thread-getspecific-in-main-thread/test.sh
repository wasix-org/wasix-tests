#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_matches '^thread_getspecific returned: 0x[0-9a-fA-F]+$'
assert_stderr_empty
