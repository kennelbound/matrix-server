FROM debian:stretch-slim

ENV COTURN_VERSION=4.5.0.7

# update and upgrade
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y && apt-get install -y --no-install-recommends \
	build-essential \
	curl \
	libevent-dev \
	libffi-dev \
	libjpeg-dev \
	libsqlite3-dev \
	libssl-dev \
	pwgen \
	python-pip \
	python-virtualenv \
	python2.7-dev \
	sqlite3 \
	unzip \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# install turn-server
ADD https://github.com/coturn/coturn/archive/$COTURN_VERSION.zip coturn.zip
RUN unzip coturn.zip \
    && rm coturn.zip \
    && cd /coturn-$COTURN_VERSION \
    && ./configure \
    && make \
    && make install \
    && rm -rf /coturn-$COTURN_VERSION

RUN mkdir -p /config
COPY files/turnserver.conf /config/turnserver.conf

EXPOSE 3478
VOLUME ["/data"]

ADD files/dumpcerts.sh /dumpcerts.sh
ADD files/start.sh /start.sh
ENTRYPOINT ["/start.sh"]
CMD ["start"]
