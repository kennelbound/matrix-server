FROM debian:stretch-slim

# Initialization
ENV MATRIX_UID=666 MATRIX_GID=666
ENV SYNAPSE_VERSION=0.31.2

# Install dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update --yes --fix-missing && apt-get upgrade --yes && \
    build_dependencies=' \
        build-essential \
        libevent-dev \
        libffi-dev \
        libjpeg-dev \
        libsqlite3-dev \
        libssl-dev' && \
    apt-get install --yes --no-install-recommends \
        $build_dependencies \
        bash \
        coreutils \
        gosu \
        inotify-tools \
        jq \
        openssl \
        pwgen \
        python-pip \
        python-virtualenv \
        python-dev \
        python-ldap \
        python-setuptools \
        python-wheel \
        python-lxml \
        sqlite3 \
        unzip \
        util-linux 


# Install synapse server
RUN pip install https://github.com/matrix-org/synapse/archive/v${SYNAPSE_VERSION}.tar.gz  

# Cleanup
RUN apt-get autoremove --yes $build_dependencies && apt-get autoremove --yes && \
    apt-get clean --yes && rm -rf /var/lib/apt/* /var/cache/apt/* /root/.cache

# Create particular user for matrix
RUN mkdir /data && \
    groupadd --gid $MATRIX_GID synapse && \ 
    useradd --gid $MATRIX_GID --uid $MATRIX_UID --home-dir /data synapse && \
    chown -R $MATRIX_UID:$MATRIX_GID /data &&  \
    chmod a+rwx /run

ADD files/homeserver.yaml /data/homeserver.yaml
COPY files/start.sh /start.sh
COPY files/dumpcerts.sh /dumpcerts.sh

EXPOSE 8448
EXPOSE 8008

VOLUME ["/data"]
ENTRYPOINT ["/start.sh"]
