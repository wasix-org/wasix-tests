#!/usr/bin/env bash
TEST_GRID_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$TEST_GRID_DIR"

SET_DATA_VARIANTS=(DIRECT SHARED DYNAMIC)
GET_DATA_VARIANTS=(DIRECT SHARED DYNAMIC)
SET_DATA_PROXY_VARIANTS=(DIRECT SHARED DYNAMIC)
GET_DATA_PROXY_VARIANTS=(DIRECT SHARED DYNAMIC)

FILES=(
  template/Makefile
  template/*.c
  template/*.h
  template/test.sh
)

echo -ne "" > .gitignore
for SET_DATA in "${SET_DATA_VARIANTS[@]}"; do
  for GET_DATA in "${GET_DATA_VARIANTS[@]}"; do
    for SET_DATA_PROXY in "${SET_DATA_PROXY_VARIANTS[@]}"; do
      for GET_DATA_PROXY in "${GET_DATA_PROXY_VARIANTS[@]}"; do
        TEST_DIR="thread-specific-set-and-get-set-${SET_DATA}-in-${SET_DATA_PROXY}-get-${GET_DATA}-in-${GET_DATA_PROXY}"
        echo "/$TEST_DIR" >> .gitignore
        rm -rf "$TEST_DIR"
        mkdir -p "$TEST_DIR"
        cp "${FILES[@]}" "$TEST_DIR"
        sed -i "s|SET_DATA=DIRECT|SET_DATA=${SET_DATA}|g" $TEST_DIR/Makefile
        sed -i "s|GET_DATA=DIRECT|GET_DATA=${GET_DATA}|g" $TEST_DIR/Makefile
        sed -i "s|SET_DATA_PROXY=DIRECT|SET_DATA_PROXY=${SET_DATA_PROXY}|g" $TEST_DIR/Makefile
        sed -i "s|GET_DATA_PROXY=DIRECT|GET_DATA_PROXY=${GET_DATA_PROXY}|g" $TEST_DIR/Makefile
      done
    done
  done
done