#!/usr/bin/env bash

# Check if required variables are available
if [ -z "${MATRIX_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable MATRIX_SERVER_URL must be set."
elif [ -z "${MATRIX_TURN_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable MATRIX_TURN_URL must be set."
elif [ -z "${MATRIX_TURN_KEY}" ]; then
    echo "Failure starting xmpp server: The environment variable MATRIX_TURN_KEY must be set."
else

    # Prepare certificates to be in the default location where prosody expects them
    if [ -f /cert/acme.json ]; then
        mkdir -p /tmp/certs && mkdir -p /config/certs
        /dumpcerts.sh /cert/acme.json /tmp/certs
        mv /tmp/certs/certs/${MATRIX_TURN_URL}.crt /tmp/certs/private/${MATRIX_TURN_URL}.key /etc/prosody/certs/
    fi

    # Apply variables from configuration file .env to synapse's configuration
    sed -i "s#{{MATRIX_SERVER_URL}}#${MATRIX_SERVER_URL}#" /config/turnserver.conf
    sed -i "s#{{MATRIX_TURN_URL}}#${MATRIX_TURN_URL}#" /config/turnserver.conf
    sed -i "s#{{MATRIX_TURN_KEY}}#${MATRIX_TURN_KEy}#" /config/turnserver.conf

    # Start coturn
    /usr/local/bin/turnserver -c /config/turnserver.conf
fi