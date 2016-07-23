FROM ubuntu:16.04

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     libreadline-dev libncurses5-dev libpcre3-dev \
     libssl-dev perl make build-essential xz-utils \
     supervisor \
  && rm -rf /var/lib/apt/lists/*

RUN curl -SL https://openresty.org/download/openresty-1.9.15.1.tar.gz | tar xf \
  && cd openresty-* \
  && ./configure --with-pcre-jit --with-ipv6 \
  && make && make install

RUN curl -SL https://nodejs.org/dist/v6.3.1/node-v6.3.1-linux-x64.tar.xz | \
  tar xf node-* -C /usr/local --strip-components=1

RUN curl -SL https://github.com/segmentio/loggly-cat/archive/v1.0.0.tar.gz | \
  tar xf -C /usr/local/bin

COPY server/* /app/server
COPY run /app
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /usr/local/openresty/nginx/sbin/nginx.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
