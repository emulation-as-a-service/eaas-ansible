#!/usr/bin/env sh

set -eu

__exit() {
    exit 0
}

__abort() {
    echo 'aborting...'
    exit 1
}

__fail() {
    echo 'installation failed!'
    echo 'aborting...'
    exit 2
}

__osinfo() {
    local field="${1:?}"
    local osinfo='/etc/os-release'
    if [ ! -e "${osinfo}" ] ; then
        echo 'target distribution is currently not supported!'
        __abort
    fi

    # print value of requested field, omit everything else
    cat "${osinfo}" | sed -n -r "s|^${field}=\"?(.+)\"?|\1|p"
}


echo 'checking python installation...'
pypath="$(command -v python || command -v python3)"
if [ -n "${pypath}" ] ; then
    echo "python found at: ${pypath}"
    echo -n 'python version: '
    "${pypath}" --version
    __exit
fi

echo 'python not found, installing...'
osid="$(__osinfo ID)"
case "${osid}" in
    ubuntu)
        sudo DEBIAN_FRONTEND=noninteractive apt-get -yq update &&
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq python3-minimal || __fail
        ;;
    centos|redhat)
        sudo yum -y update && sudo yum install -y python || __fail
        ;;
    *)
        osname="$(__osinfo PRETTY_NAME)"
        echo "unsupported distribution: ${osid} (${osname})"
        __abort
        ;;
esac
