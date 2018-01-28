FROM alpine:3.7
MAINTAINER Janne K <0x022b@gmail.com>

HEALTHCHECK CMD nc -zw5 google.com 443 || exit 1
ENTRYPOINT ["docker-entrypoint"]
CMD ["container-daemon"]

ARG VOLUME=/data

RUN \
apk upgrade --no-cache && \
apk add --no-cache \
	ca-certificates \
	iptables \
	ip6tables \
	libcap \
	openvpn \
	su-exec \
	sudo && \
setcap cap_net_admin+ep /usr/sbin/openvpn && \
deluser openvpn && \
mkdir -m 0777 -p "${VOLUME}"

VOLUME ["${VOLUME}"]
WORKDIR "${VOLUME}"

COPY rootfs/ /
