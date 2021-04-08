FROM gravicore/alpine-node-chamber:latest

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh autoconf automake libtool build-base pkgconfig"]

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
