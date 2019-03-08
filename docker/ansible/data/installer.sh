#!/usr/bin/env sh

set -e  # fail on error
set -x  # print executed commands

# install system deps
apk add --no-cache \
    openssh-client \
    rsync \
    python3 \
    python3-dev \
    openssl \
    openssl-dev \
    libffi \
    libffi-dev \
    musl-dev \
    make \
    gcc

# install latest ansible + deps
pip3 install -r py-deps.txt

# remove dev packages
apk del gcc \
    python3-dev \
    openssl-dev \
    libffi-dev \
    musl-dev \
    make
