#!/usr/bin/env sh

set -e

__usage() {
    local cmdname="$(basename -- "$0")"

    echo "
${cmdname} - Script for building eaas-server source code

USAGE:
    ${cmdname} <base-dir> <source-dir> [<profiles>]

DESCRIPTION:
    This will start a minimal docker-container and build eaas-server
    sources located in <base-dir>/<source-dir> using Maven.

ARGUMENTS:
    <base-dir>
        Absolute path to directory containing the .git subdirectory.
        NOTE: This is needed for some maven-plugins,
              to work correctly inside a docker-volume.

    <source-dir>
        Path to the source-directory containing main pom.xml
        NOTE: This path must be relative to <base-dir>!

    <profiles>
        Optional list of comma-separated profiles to build.
"
}


if [ "$1" = '-h' ] || [ "$1" = '--help' ] ; then
    __usage
    exit 0
fi

gitdir="${1:?git base directory missing!}"
srcdir="${2:?source directory missing!}"
dstdir='/var/work'

cmd='mvn clean install -pl ear -am'
if [ -n "$3" ] ; then
    # build only specified profiles
    cmd="${cmd} -P $3"
fi

# maven's cache-dir
m2src='/tmp/maven-cache'
m2dst='/home/eaas/.m2'
mkdir -p "${m2src}"

exec docker run --rm --tty --interactive --name eaas-builder \
    --volume "${m2src}:${m2dst}" \
    --volume "${gitdir}:${dstdir}" \
    --workdir "${dstdir}/${srcdir}" \
    eaas/maven ${cmd}
