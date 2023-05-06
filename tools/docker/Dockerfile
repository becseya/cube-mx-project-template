FROM ubuntu:22.04

COPY install-build-tools.sh .

RUN ./install-build-tools.sh

# Match PID inside container
ARG DOCKER_USER DOCKER_UID DOCKER_GID

RUN addgroup --gid $DOCKER_GID $DOCKER_USER
RUN adduser --uid $DOCKER_UID --gid $DOCKER_GID --disabled-password --no-create-home $DOCKER_USER

USER $DOCKER_USER
