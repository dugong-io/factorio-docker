FROM frolvlad/alpine-glibc:alpine-3.4

MAINTAINER https://github.com/dtandersen/docker_factorio_server

COPY ./factorio.crt /opt/factorio.crt

ENV VERSION=0.14.14 \
    SHA1=decd1ef34a75b309791e65bc92b164f10479753b

RUN apk --update add bash curl && \
    curl -sSL --cacert /opt/factorio.crt \
        https://www.factorio.com/get-download/$VERSION/headless/linux64 \
        -o /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    echo "$SHA1  /tmp/factorio_headless_x64_$VERSION.tar.gz" | sha1sum -c && \
    tar xzf /tmp/factorio_headless_x64_$VERSION.tar.gz --directory /opt && \
    rm /tmp/factorio_headless_x64_$VERSION.tar.gz

VOLUME /opt/factorio/saves /opt/factorio/mods

EXPOSE 34197/udp 27015/tcp

COPY ./docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]
