FROM alpine:3.23
LABEL maintainer="Lucas Mendelowski"

RUN apk --no-cache add bash docker-cli dnsmasq ed &&\
    mkdir -p /etc/dnsmasq.d

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY run.sh /run.sh

ENV DNS_DOMAIN="test" FALLBACK_DNS="8.8.8.8" EXTRA_HOSTS="" HOSTMACHINE_IP="172.17.0.1" NAMING="default" NETWORK="bridge"

EXPOSE 53/udp

ENTRYPOINT ["/run.sh"]
