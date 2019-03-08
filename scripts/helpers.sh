#
# Helper functions to be used by other scripts
#

__newline() {
    echo ''
}

__info() {
    if [ -n "$2" ] ; then
        local prefix="$1"
        local msg="$2"
    else
        local prefix='[INFO]'
        local msg="$1"
    fi

    echo "${prefix} ${msg}"
}
