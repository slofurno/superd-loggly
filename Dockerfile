FROM ubuntu:16.04

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     ca-certificates curl \
     libreadline-dev libncurses5-dev libpcre3-dev \
     libssl-dev perl make build-essential xz-utils \
     supervisor \
  && rm -rf /var/lib/apt/lists/*

RUN curl -SL https://openresty.org/download/openresty-1.9.15.1.tar.gz | tar xz \
  && cd openresty-* \
  && ./configure --with-pcre-jit --with-ipv6 \
  && make && make install

RUN curl -SL https://nodejs.org/dist/v6.3.1/node-v6.3.1-linux-x64.tar.xz | \
  tar xJ -C /usr/local --strip-components=1

RUN curl -SL https://github.com/segmentio/loggly-cat/archive/v1.0.0.tar.gz | \
  tar xz -C /usr/local/bin

RUN mkdir -p /var/log/nginx
COPY server/* /app/server
COPY run /app
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /usr/local/openresty/nginx/conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
