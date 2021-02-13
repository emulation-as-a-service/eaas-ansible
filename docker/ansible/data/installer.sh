#!/usr/bin/env sh

set -e  # fail on error
set -x  # print executed commands

# install system deps
apk add --no-cache \
    openssh-client \
    rsync \
    python3 \
    py3-jmespath \
    py3-requests \
    py3-google-auth \
    py3-cryptography \
    py3-passlib \
    py3-bcrypt \
    ansible
