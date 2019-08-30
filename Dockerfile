FROM alpine

LABEL AUTHOR=Ataris<ataris@sina.com>

WORKDIR /app

ARG DPORT=8080

ENV RPC_SECRET=""
ENV ARIA2_SSL=false
ENV PORT=$DPORT

RUN apk update \
    && apk add aria2 wget --no-cache \
    && wget -qO- https://getcaddy.com | bash -s personal

RUN mkdir -p /app/ariang \
    && version=1.1.3 \
    && wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip \
    && unzip AriaNg-${version}.zip -d /app/ariang \
    && chmod -R 755 /app/ariang \
    && rm -rf AriaNg-${version}.zip

ADD ./startup.sh /app/
ADD ./Caddyfile /app/caddy/
ADD ./conf /app/aria2/conf

VOLUME /app/aria2/conf

EXPOSE 6800 $DPORT

CMD ["./startup.sh"]