FROM alpine:3.23
LABEL maintainer="Lucas Mendelowski"

ENV DNS_DOMAIN="test" \
    FALLBACK_DNS="8.8.8.8" \
    EXTRA_HOSTS="" \
    HOSTMACHINE_IP="172.17.0.1" \
    NAMING="default" \
    NETWORK="bridge"

RUN apk --no-cache add bash docker-cli dnsmasq ed
RUN  mkdir -p /etc/dnsmasq.d

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY run.sh /run.sh

EXPOSE 53/udp

ENTRYPOINT ["/run.sh"]
