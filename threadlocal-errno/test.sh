#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all
run main

assert_success
assert_stdout_is $'main errno 1\nthread 0 errno 100\nthread 1 errno 101\nthread 2 errno 102\nthread 3 errno 103'
assert_stderr_empty
