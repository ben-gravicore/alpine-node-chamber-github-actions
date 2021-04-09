FROM gravicore/alpine-node-chamber:latest

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh autoconf automake libtool build-base pkgconfig nasm util-linux"]

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
