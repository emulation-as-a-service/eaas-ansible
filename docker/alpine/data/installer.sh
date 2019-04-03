#!/usr/bin/env sh

set -e  # fail on error

name="${1:?}"
uid="${2:?}"
gid="${3:?}"

# reset user/group DB to contain only the root user/group
echo 'root:x:0:0:root:/root:/bin/ash' > /etc/passwd
echo 'root:x:0:root' > /etc/group

# create a new container's user/group matching a host's UID/GID
addgroup -g "${gid}" "${name}"
adduser -D -G "${name}" -u "${uid}" -g "${name}" "${name}"

