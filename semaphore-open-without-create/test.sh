#!/usr/bin/env bash
source "$(git rev-parse --show-toplevel)/lib/test-utils.sh"

make all

expect test.expect $RUNNER ./main
