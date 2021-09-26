#!/usr/bin/env sh

set -eu

kind="$1"

__info() {
    echo "[HOOKS] $1"
}

workdir="$(dirname -- "$0")/${kind}"
if [ ! -d "${workdir}" ]; then
    __info "No ${kind} hooks found!"
    exit 0
fi

cd "${workdir}"

__info "Running ${kind} hooks..."
for script in $(ls ./); do
    __info "--> ${script}"
    ./${script}
done

__info "Running ${kind} hooks finished!"
