# Plausible.io on HTTPS

Run Plausible.io with Traefik as a reverse-proxy. This will let you have a SSL
certificate on your self-hosted instance.

## Setup

- Clone this repository
- Edit `geoip/geoip.conf` and use credentials from MaxMind
- Change `traefik/acme.json` permissions: `chmod 600 traefik/acme.json`
- Edit `traefik/traefik.toml` and change email address with your own
- Edit `docker-compose.yml` and change domain name with your own
- Edit `plausible-conf.env`

## After first successful run

Disable Traefik dashboard, or it will be publicly availabe in production.

- Edit `traefik/traefik.toml` and remove `[api]` section
- Edit `traefik/docker-compose.traefik.yml` and remove `"8080:8080"` port
