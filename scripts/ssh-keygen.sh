#!/usr/bin/env sh

set -e

__usage() {
    local cmdname="$(basename -- "$0")"

    echo "
${cmdname} - Script for generating secure ssh-keys

USAGE:
    ${cmdname} <keyfile> [<comment>]

DESCRIPTION:
    This will start a minimal docker-container and generate
    a new secure pair of public/private ssh-keys.

ARGUMENTS:
    <keyfile>
        Path to store the private key in. Matching public
        key will be store in <keyfile>.pub

    <comment>
        Optional comment to add to the public key.
"
}


selfdir="$(cd "$(dirname -- "$0")" && pwd -P)"
. "${selfdir}/helpers.sh"

if [ "$1" = '-h' ] || [ "$1" = '--help' ] ; then
    __usage
    exit 0
fi

outfile="${1:?output path for ssh-key missing!}"
comment="${2:-eaas-admin}"

keyname="$(basename -- "${outfile}")"
keydir="$(dirname -- "${outfile}")"
keydir="$(cd "${keydir}" && pwd -P)"
workdir='/var/work'

docker run --rm --tty --interactive --name ssh-keygen \
    --volume "${keydir}:${workdir}" \
    --workdir "${workdir}" \
    eaas/ssh-keygen \
    ssh-keygen -t ed25519 -N '' -C "${comment}" -f "${keyname}"

chmod -v 400 ${keydir}/${keyname}*

__newline
__info 'generated ssh-key pair:'
echo "${keydir}/${keyname}.pub"
echo "${keydir}/${keyname}"
