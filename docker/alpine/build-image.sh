#!/usr/bin/env sh

exec docker build --force-rm \
    --build-arg "uid=$(id -u)" \
    --build-arg "gid=$(id -g)" \
    --tag eaas/alpine \
    .
