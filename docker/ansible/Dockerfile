FROM eaas/alpine
ARG workdir='/var/work'
ADD ./data "${workdir}"
RUN cd "${workdir}" && ./installer.sh && rm -r "${workdir}"
USER eaas
