#!/usr/bin/env sh

exec docker build --force-rm \
    --build-arg "uid=$(id --user)" \
    --build-arg "gid=$(id --group)" \
    --tag eaas/alpine \
    .
