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

RUN cd /usr/local/bin && curl -SOL https://github.com/segmentio/loggly-cat/releases/download/v1.0.0/loggly-cat && chmod +x ./loggly-cat

WORKDIR app
ENV HOME="/app"

RUN chmod 0777 -R /usr/local
RUN chmod 0777 -R /app
RUN echo "127.0.1.4 pokemon" | tee -a /etc/hosts

COPY node_modules /app/node_modules
COPY server/* ./server/
COPY run .
COPY supervisord.conf /app/supervisord.conf
COPY entrypoint ./

RUN useradd testuser
USER testuser

CMD ["/app/entrypoint"]
