#!/usr/bin/env sh

outlen="$1"
if [ -z "${outlen}" ] ; then
    outlen='32'
fi

selfdir="$(cd "$(dirname -- "$0")" && pwd -P)"
. "${selfdir}/helpers.sh"

__info "Random password of length ${outlen}":

exec docker run --rm --tty --interactive --name pwdgen \
    eaas/pwdgen \
    openssl rand -base64 "${outlen}"
