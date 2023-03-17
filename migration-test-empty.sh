#!/bin/bash

set -euxo pipefail

echo "Downloading and installing spawnctl..."
curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
export PATH=$HOME/.spawnctl/bin:$PATH
echo "spawnctl successfully installed"

export SPAWN_EMPTY_IMAGE=postgres-empty

echo
echo "Creating Pagila backup Spawn data container from empty image"
emptyContainerName=$(spawnctl create data-container --image $SPAWN_EMPTY_IMAGE --accessToken "$SPAWNCTL_ACCESS_TOKEN" -q)

emptyContainerJson=$(spawnctl get data-container "$emptyContainerName" -o json)
host=$(echo "$emptyContainerJson" | jq -r '.host')
port=$(echo "$emptyContainerJson" | jq -r '.port')
user=$(echo "$emptyContainerJson" | jq -r '.user')
password=$(echo "$emptyContainerJson" | jq -r '.password')

echo "Successfully created Spawn data container '$emptyContainerName'"
echo

docker pull postgres:13-alpine > /dev/null 2>&1
docker pull flyway/flyway > /dev/null 2>&1

echo
echo "Starting migration of database with flyway"

docker run --net=host --rm -e PGPASSWORD="$password" postgres:13-alpine psql -h "$host" -p "$port" -U "$user" -c "create database pagila"
docker run --net=host --rm -v "$PWD"/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://$host:$port/pagila" -user="$user" -password="$password"

echo "Successfully migrated empty database"
echo

spawnctl delete data-container "$emptyContainerName" --accessToken "$SPAWNCTL_ACCESS_TOKEN" -q

echo "Successfully cleaned up the Spawn data container '$emptyContainerName'"