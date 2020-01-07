#!/usr/bin/env sh

# check if sudo is required to run docker
docker info > /dev/null 2>&1 || sudocmd='sudo'

exec ${sudocmd} docker build --force-rm --tag eaas/ansible .
