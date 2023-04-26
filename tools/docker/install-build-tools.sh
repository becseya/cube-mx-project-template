#!/bin/bash

set -euxo pipefail

sudo apt-get update

sudo apt-get install -y \
    bash-completion \
    make \
    git \
    clang-format \
    pkg-config
