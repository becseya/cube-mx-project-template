#!/bin/bash

set -e

SCRIP_DIR=$(dirname $(realpath $0))
IMAGE_NAME="cube-my-template-builder"
CONTAINER_NAME="my-$IMAGE_NAME"
REPO_ROOT=$(realpath "$SCRIP_DIR/../..")

if ! docker images | grep "$IMAGE_NAME " >/dev/null; then
	echo "Building image..."
	docker build --build-arg DOCKER_USER=$(whoami) --build-arg DOCKER_GID=$(id -g) --build-arg DOCKER_UID=$(id -u) -t "$IMAGE_NAME" "$SCRIP_DIR"
fi

if ! docker ps | grep -o "$CONTAINER_NAME$" >/dev/null; then
	echo "Starting container..."

	if docker ps --all | grep -o "$CONTAINER_NAME$" >/dev/null; then
		docker start "$CONTAINER_NAME"
	else
		docker run -dit -v "$REPO_ROOT:/workdir" --name "$CONTAINER_NAME" "$IMAGE_NAME"
	fi
fi

if test -n "$1"; then
	docker exec -t "$CONTAINER_NAME" bash -c "cd /workdir && $@"
else
	docker exec -i -t "$CONTAINER_NAME" bash -c "cd /workdir && bash --rcfile /etc/bash_completion"
fi
