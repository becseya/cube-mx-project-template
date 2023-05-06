#!/bin/bash

set -euxo pipefail

if [ "$EUID" -ne 0 ]; then
    exec sudo -s "$0" "$@"
fi

apt-get update

apt-get install -y \
    bash-completion \
    make \
    git \
    clang-format \
    pkg-config
