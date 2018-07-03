#!/usr/bin/env bash

chown -R synapse:synapse /data

# Check if required variables are available
if [ -z "${MATRIX_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable MATRIX_SERVER_URL must be set."
elif [ -z "${MATRIX_TURN_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable MATRIX_TURN_URL must be set."
elif [ -z "${MATRIX_TURN_KEY}" ]; then
    echo "Failure starting xmpp server: The environment variable MATRIX_TURN_KEY must be set."
else

    # Generate config if not available
    if [ ! -f /data/homeserver.yaml ]; then
    cd /data
    gosu synapse python -m synapse.app.homeserver \
        --generate-config \
        --config-path /data/homeserver.yaml \
        --report-stats no \
        --server-name "${MATRIX_SERVER_URL}"
    fi

    # TODO: Use the letsencrypt certificates - /dumpcerts.sh /cert/acme.json /data
    # TODO: Check if URL and one of an eventual existing configuration differ

    # Apply variables from configuration file .env to synapse's configuration
    sed -i "s#{{MATRIX_SERVER_URL}}#${MATRIX_SERVER_URL}#" /data/homeserver.yaml
    sed -i "s#{{MATRIX_TURN_URL}}#${MATRIX_TURN_URL}#" /data/homeserver.yaml
    sed -i "s#{{MATRIX_TURN_KEY}}#${MATRIX_TURN_KEY}#" /data/homeserver.yaml

    # Start synapse
    gosu synapse python -m synapse.app.homeserver -c /data/homeserver.yaml
fi