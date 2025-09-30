#!/usr/bin/env bash
set -euo pipefail

sudo apt update > /dev/null
sudo apt install -y clang llvm git git-lfs build-essential make cmake libtool pkg-config yq  > /dev/null

curl -sSf https://raw.githubusercontent.com/wasix-org/wasix-clang/refs/heads/main/setup.sh | bash
