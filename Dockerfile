FROM alpine:3.7

MAINTAINER Cloud Posse, LLC

ENV TELEPORT_VERSION v2.4.2
ENV TELEPORT_DOWNLOAD_URL https://github.com/gravitational/teleport/releases/download/${TELEPORT_VERSION}/teleport-${TELEPORT_VERSION}-linux-amd64-bin.tar.gz

RUN apk upgrade --update \
    && apk add bash tzdata wget tar ca-certificates coreutils curl \
    && wget ${TELEPORT_DOWNLOAD_URL} \
    && tar -zxvf teleport-${TELEPORT_VERSION}-linux-amd64-bin.tar.gz \
    && mv teleport/tctl teleport/teleport teleport/tsh /usr/local/bin \
    && mkdir /etc/teleport /lib64 \
    && ln -sf /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && rm -rf /*.tar.gz /teleport /var/cache/apk/*

ENV GOMPLATE_VERSION 2.4.0
RUN curl --fail -sSL -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64-slim \
    && chmod +x /usr/local/bin/gomplate

VOLUME /var/lib/teleport /etc/teleport /host

ADD rootfs/ /

RUN chmod +x /etc/teleport/teleport-node.sh
RUN chmod +x /etc/teleport/teleport-proxy.sh
RUN chmod +x /etc/teleport/teleport-auth.sh

EXPOSE 3022-3025 3080

ENTRYPOINT ["/etc/teleport/teleport-node.sh"]
