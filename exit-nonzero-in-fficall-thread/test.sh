#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
source ../lib/assert.sh
source ../lib/test-utils.sh

make main
set +e
run main
exitcode=$?

assert_eq "FFI call in thread" "$(cat stdout.log)" "stdout did not match expected value"
assert_eq "" "$(cat stderr.log)" "stderr did not match expected value"
set -e

assert_eq 99 "$exitcode" "Expected exit code 99 but got $exitcode"
