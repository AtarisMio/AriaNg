
FROM ubuntu:20.04 AS builder
ARG VERSION=1.2.3
WORKDIR /tmp/
ADD https://github.com/mayswind/AriaNg/releases/download/${VERSION}/AriaNg-${VERSION}-AllInOne.zip .
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install unzip && \
    mkdir -p /tmp/aria-ng && \
    unzip /tmp/AriaNg-${VERSION}-AllInOne.zip -d /tmp/aria-ng && \
    echo 'done'

FROM nginx:alpine
ADD default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /tmp/aria-ng/* /usr/share/nginx/html/