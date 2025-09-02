#!/usr/bin/env bash
TEST_GRID_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$TEST_GRID_DIR"

CATCHER_VARIANTS=("static" "shared")
THROWER_VARIANTS=("static" "shared")

FILES=(
  template/Makefile
  template/*.cpp
  template/*.hpp
  template/test.sh
)

echo -ne "" > .gitignore
for CATCHER in "${CATCHER_VARIANTS[@]}"; do
  for THROWER in "${THROWER_VARIANTS[@]}"; do
    TEST_DIR="${THROWER}-thrower-${CATCHER}-catcher"
    echo "/$TEST_DIR" >> .gitignore
    rm -rf "$TEST_DIR"
    mkdir -p "$TEST_DIR"
    cp "${FILES[@]}" "$TEST_DIR"
    sed -i "s|THROWER=static|THROWER=${THROWER}|g" $TEST_DIR/Makefile
    sed -i "s|CATCHER=static|CATCHER=${CATCHER}|g" $TEST_DIR/Makefile
  done
done