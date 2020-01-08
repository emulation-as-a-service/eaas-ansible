#!/usr/bin/env sh

uid="$(id -u)"
gid="$(id -g)"

# check if sudo is required to run docker
docker info > /dev/null 2>&1 || sudocmd='sudo'

exec ${sudocmd} docker build --force-rm \
    --build-arg "uid=$(id -u)" \
    --build-arg "gid=$(id -g)" \
    --tag eaas/alpine \
    .
