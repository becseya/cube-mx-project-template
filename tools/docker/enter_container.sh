#!/bin/bash

set -e

SCRIP_DIR=$(dirname $(realpath $0))
IMAGE_NAME="cube-my-template-builder"
REPO_ROOT=$(realpath "$SCRIP_DIR/../..")

if ! docker images | grep "$IMAGE_NAME " >/dev/null; then
    echo "Building image..."
    docker build --build-arg DOCKER_USER=$(whoami) --build-arg DOCKER_GID=$(id -g) --build-arg DOCKER_UID=$(id -u) -t "$IMAGE_NAME" "$SCRIP_DIR"
fi

if test -n "$1"; then
    ARGS="$@"
else
    echo "Entering container..."
    ARGS="bash --rcfile /etc/bash_completion"
fi

if test -t 0; then
    INTERACTIVE='-it'
fi

docker run $INTERACTIVE --rm -v "$REPO_ROOT:/workdir" "$IMAGE_NAME" bash -c "cd /workdir && $ARGS"
