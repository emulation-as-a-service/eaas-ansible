#!/usr/bin/env sh

set -e  # fail on error

__uid2name() {
    getent passwd "$1" | cut -d : -f 1
}

__gid2name() {
    getent group "$1" | cut -d : -f 1
}


name="${1:?}"
uid="${2:?}"
gid="${3:?}"

# delete exisiting user with target uid
curname="$(__uid2name "${uid}")"
if [ -n "${curname}" ] ; then
    deluser "${curname}"
fi

# delete exisiting group with target gid
curname="$(__gid2name "${gid}")"
if [ -n "${curname}" ] ; then
    delgroup "${curname}"
fi

# create a new container's user/group matching a host's UID/GID
addgroup -g "${gid}" "${name}"
adduser -D -G "${name}" -u "${uid}" -g "${name}" "${name}"

