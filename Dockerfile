FROM gravicore/alpine-node-chamber:latest

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh lspcu autoreconf"]

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
