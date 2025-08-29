#!/usr/bin/env bash
set -euo pipefail

# Directory of this script
LIB_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Directory where the current test is located
TEST_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[1]:-'.'}" )" &> /dev/null && pwd )
# Root of the git repository
GIT_TOPLEVEL=$(git rev-parse --show-toplevel)
# Name of the current test, relative to the git root
TEST_NAME=$(realpath -s --relative-to="$GIT_TOPLEVEL" "$TEST_DIR")

source "$LIB_DIR/assert.sh"
cd "$TEST_DIR"
trap "print_report" EXIT

EXIT_CODE=

# Run the specified file using $RUNNER (or use a native runner if not set)
#
# Outputs stdout to stdout.log and stderr to stderr.log
# Sets the global variable $EXIT_CODE to the exit code of the program
#
# Uss `assert_stdout_is` and `assert_stderr_is` to check the output
#
# Use `assert_exit_code` to check the exit code against a value
# Use `assert_success` to check that the exit code is 0
run() {
    # set -x
    # trap 'set +x' RETURN
    EXIT_CODE=0


    RUNNER=${RUNNER:-../lib/wrappers/native-clang-runner}
    local executable="$1"
    shift

    "$RUNNER" "./$executable" "$@" > stdout.log 2> stderr.log || EXIT_CODE=$?

    return 0
}

assert_stdout_is() {
    local expected="$1"
    assert_eq "$expected" "$(cat stdout.log)" 'stdout did not match expected value:\\n    actual: \"$actual\"\\n  expected: \"$expected\"' 'stdout matched expected value$NONE'
}

assert_stderr_is() {
    local expected="$1"
    assert_eq "$expected" "$(cat stderr.log)" 'stderr did not match expected value:\\n    actual: \"$actual\"\\n  expected: \"$expected\"' 'stderr matched expected value$NONE'
}

assert_stdout_empty() {
    assert_eq "" "$(cat stdout.log)" 'stdout is not empty:\\n stdout: \"$actual\"' 'stdout is empty$NONE'
}

assert_stderr_empty() {
    assert_eq "" "$(cat stderr.log)" 'stderr is not empty:\\n stderr: \"$actual\"' 'stderr is empty$NONE'
}

assert_stdout_contains() {
    local expected="$1"
    assert_contains "$expected" "$(cat stdout.log)" 'stdout did not contain \"$expected\":\\n  stdout: \"$actual\"' 'stdout contains \"$expected\"'
}

assert_stderr_contains() {
    local expected="$1"
    assert_contains "$expected" "$(cat stderr.log)" 'stderr did not contain \"$expected\":\\n  stderr: \"$actual\"' 'stderr contains \"$expected\"'
}

assert_exit_code() {
    local expected="${1}"
    local actual="${2-$EXIT_CODE}"
    assert_eq "$expected" "$actual" 'exit code \"$actual\" did not match expected value of \"$expected\"' 'exited with the correct exit code \"$expected\"'
}

assert_success() {
    local actual="${1-$EXIT_CODE}"
    assert_eq "0" "$actual" 'exit code \"$actual\" indicates the program failed' 'program exited successfully$NONE'
}
