FROM alpine:3.9
ARG uid
ARG gid
ARG name=eaas

# create a new container's user/group matching a host's UID/GID
RUN addgroup -g "${gid}" "${name}" && \
    adduser -D -G "${name}" -u "${uid}" -g "${name}" "${name}"
