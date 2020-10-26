#!/bin/bash
docker-compose \
  -f docker-compose.yml \
  -f geoip/docker-compose.geoip.yml \
  -f traefik/docker-compose.traefik.yml \
  up --detached
