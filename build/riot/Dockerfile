FROM debian:stretch-slim

# Initialization
ENV RIOT_VERSION=0.13.4

# Install dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update --yes --fix-missing && apt-get upgrade --yes && \
    build_dependencies=' \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        gnupg2 \
        git \
        libevent-dev \
        libffi-dev \
        libjpeg-dev \
        libsqlite3-dev \
        libssl-dev \
        unzip' && \
    apt-get install --yes --no-install-recommends \
        $build_dependencies \
        bash \
        coreutils

RUN curl -sSO https://deb.nodesource.com/gpgkey/nodesource.gpg.key && \
    apt-key add nodesource.gpg.key && \
    echo "deb https://deb.nodesource.com/node_10.x stretch main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update -q && apt-get install -y nodejs

RUN npm install -g webpack http-server

# Install the Riot web application
RUN curl -sL https://github.com/vector-im/riot-web/archive/v${RIOT_VERSION}.tar.gz | tar -xz && \
    mv riot-web-* /riot-web && cd /riot-web && \
    npm install && rm -rf /riot-web/node_modules/phantomjs-prebuilt/phantomjs && \
    npm run build

# Cleanup
RUN apt-get autoremove --yes $build_dependencies && apt-get autoremove --yes && \
    apt-get clean --yes && rm -rf /var/lib/apt/* /var/cache/apt/* /root/.cache

COPY files/config.json /riot-web/webapp/
COPY files/start.sh /start.sh

EXPOSE 8080
VOLUME ["/data"]
WORKDIR /riot-web/webapp
ENTRYPOINT ["/start.sh"]