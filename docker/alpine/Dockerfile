FROM alpine:3.13
ARG uid
ARG gid
ARG name=eaas
ARG workdir='/var/work'
ADD ./data "${workdir}"
RUN cd "${workdir}" && ./installer.sh "${name}" "${uid}" "${gid}" && rm -r "${workdir}"

