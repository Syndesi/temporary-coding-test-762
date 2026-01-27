# SENEC coding example

## Getting started

Requirements:

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

**IMPORTANT**: The default `docker-compose.yml`-file imports the current user's SSH keys in the form of a readonly
volume. If this is un 

```bash
docker compose build
docker compose up -d
```