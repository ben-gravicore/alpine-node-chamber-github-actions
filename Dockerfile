FROM gravicore/alpine-node-chamber:latest

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh"]
RUN mkdir /src
COPY ["src", "/src/"]
RUN ls /src
ENTRYPOINT ["/src/main.sh"]
