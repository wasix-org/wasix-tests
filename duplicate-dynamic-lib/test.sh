#!/usr/bin/env bash
source ../lib/test-utils.sh

make all
run main

assert_success
assert_stderr_empty