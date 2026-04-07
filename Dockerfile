FROM alpine:3.21
LABEL maintainer="Lucas Mendelowski"

RUN apk --no-cache add bash curl dnsmasq ed

ARG TARGETARCH
RUN DOCKER_ARCH=$([ "$TARGETARCH" = "arm64" ] && echo "aarch64" || echo "x86_64") &&\
    curl -sSL "https://download.docker.com/linux/static/stable/${DOCKER_ARCH}/docker-27.5.1.tgz" | tar zx -C /tmp &&\
    mv /tmp/docker/docker /usr/local/bin/ &&\
    rm -rf /tmp/docker &&\
    mkdir -p /etc/dnsmasq.d

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY run.sh /run.sh

ENV DNS_DOMAIN="test" FALLBACK_DNS="8.8.8.8" EXTRA_HOSTS="" HOSTMACHINE_IP="172.17.0.1" NAMING="default" NETWORK="bridge"

EXPOSE 53/udp

ENTRYPOINT ["/run.sh"]
