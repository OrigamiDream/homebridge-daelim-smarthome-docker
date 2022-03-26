#!/bin/zsh

ENVS=(private shared)
ENVS_DIR=envs
COMPOSE_CONFIG=docker-compose.yml

echo "Shutting down running containers..."
for value in "${ENVS[@]}"; do
  echo "Shutdown - homebridge-$value"
  docker-compose \
      -p "homebridge-$value" \
      down
done

PUID=$(python3 python/uids.py)
PGID=$(python3 python/gids.py)

for value in "${ENVS[@]}"; do
  HOST_PUID=$PUID \
  HOST_PGID=$PGID \
  docker-compose \
      -p "homebridge-$value" \
      -f "$COMPOSE_CONFIG" \
      --env-file "$ENVS_DIR/.env.$value" \
      up -d
done