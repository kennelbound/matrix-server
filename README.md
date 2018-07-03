# Matrix server

Easy to setup and full featured [matrix](https://matrix.org) server, based on Docker Compose, to participate in an open network for secure, decentralized communication.

## Idea

Everybody needs an open communication tool without walls and gated communities. This configuration allows you to setup a solid full working matrix server without much hassle.

## Components

[Docker](https://www.docker.com/) images containing the [Synapse](https://github.com/matrix-org/synapse) server and the web client [Riot](https://github.com/vector-im/riot-web). It is orchestrated by the reverse proxy [traefik](https://traefik.io) and provides out-of-the-box secure connections with certificates by [Let's Encrypt](https://letsencrypt.org).

## Installation

Before you start, you have to configure your domain's **dynamic name server (DNS) settings** by adding the following entries:

```

A/AAAA record: matrix.YOURDOMAIN.TLD
A/AAAA record: chat.YOURDOMAIN.TLD
SRC record: _matrix._tcp.YOURDOMAIN.TLD matrix.YOURDOMAIN.TLD:8448
```

After this, you can **install the matrix server** just with a few easy steps:

* Make sure you have recent versions [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) working.
* Copy over the [configuration file](./env-example) and edit it: `cp env-example .env`
* Run docker compose to spin it all up: `docker-compose up -d`

Done.

## Variables

Only three variables you have to specify in the [configuration file](./env-example).

* `NAME`: A freely choosable name for this server and service.
* `ADMIN_EMAIL`: An email address of the administrator.
* `MATRIX_SERVER_URL`: The domain for the server.
* `MATRIX_CLIENT_URL`: The domain for the web client. Can be the same as the server.


### License

This is Free and Open Source Software. Released under the [MIT license](./LICENSE.md). You can use, study share and improve it at your will. Any [contribution](./CONTRIBUTING.md) is highly appreciated. Only together we can make the world a better place.
