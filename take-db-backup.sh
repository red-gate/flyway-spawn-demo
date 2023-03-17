#!/bin/bash

set -euxo pipefail

echo "Downloading and installing spawnctl..."
curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
export PATH=$HOME/.spawnctl/bin:$PATH
echo "spawnctl successfully installed"

echo "Downloading and installing TDK..."
curl -sL https://synthesized-io.github.io/tdk-install/install.sh | sh > /dev/null 2>&1
export PATH=$HOME/.tdk/bin:$PATH
echo "TDK successfully installed"

databaseName="pagila"
mkdir backups

export SPAWN_EMPTY_IMAGE=postgres-empty-13:prod

if ! spawnctl get data-images | grep -q postgres-empty-13; then
  echo "Creating empty postgres data image..."
  echo

  spawnctl create data-image --file ./postgres-empty.yaml --lifetime 336h --accessToken "$SPAWNCTL_ACCESS_TOKEN" -q
  echo "Successfully created empty postgres data image '$SPAWN_EMPTY_IMAGE'"
fi

echo
echo "Creating tmpDb postgres container"
tmpDbContainerName=$(spawnctl create data-container --image "$SPAWN_EMPTY_IMAGE" --lifetime 10m --accessToken "$SPAWNCTL_ACCESS_TOKEN" -q)
tmpDbJson=$(spawnctl get data-container "$tmpDbContainerName" -o json)
tmpDbHost=$(echo "$tmpDbJson" | jq -r '.host')
tmpDbPort=$(echo "$tmpDbJson" | jq -r '.port')
tmpDbUser=$(echo "$tmpDbJson" | jq -r '.user')
tmpDbPassword=$(echo "$tmpDbJson" | jq -r '.password')

docker pull postgres:13-alpine > /dev/null 2>&1

echo
echo "Copying schema..."

docker run --net=host --rm -v "$PWD"/backups:/backups/ -e PGPASSWORD="$PAGILA_PASSWORD" postgres:13-alpine pg_dump -h "$PAGILA_HOST" -p 5432 -U "$PAGILA_USERNAME" -C -O -s -f /backups/pagila_schema.sql "$databaseName"
docker run --net=host --rm -v "$PWD"/backups:/backups/ -e PGPASSWORD="$tmpDbPassword" postgres:13-alpine psql -h "$tmpDbHost" -p "$tmpDbPort" -U "$tmpDbUser" -f /backups/pagila_schema.sql

echo
echo "Transforming prod database using TDK into tmp database..."

tdk \
    --input-url="jdbc:postgresql://$PAGILA_HOST:5432/pagila" --input-username="$PAGILA_USERNAME" --input-password="$PAGILA_PASSWORD" \
    --output-url="jdbc:postgresql://$tmpDbHost:$tmpDbPort/pagila" --output-username="$tmpDbUser" --output-password="$tmpDbPassword" \
    --config-file "$PWD"/tdk/config.yaml

echo
echo "Restoring staff-store links..."

docker run --net=host --rm -v "$PWD"/tdk:/tdk/ -e PGPASSWORD="$tmpDbPassword" postgres:13-alpine psql -h "$tmpDbHost" -p "$tmpDbPort" -U "$tmpDbUser" -f /tdk/set_staff_stores.sql "$databaseName"

echo
echo "Backing-up tmp database..."

docker run --net=host --rm -v "$PWD"/backups:/backups/ -e PGPASSWORD="$tmpDbPassword" postgres:13-alpine pg_dump -h "$tmpDbHost" -p "$tmpDbPort" -U "$tmpDbUser" -C -f /backups/pagila.sql "$databaseName"

spawnctl delete data-container "$tmpDbContainerName" --accessToken "$SPAWNCTL_ACCESS_TOKEN" -q
echo "Successfully cleaned up the Spawn data container '$tmpDbContainerName'"

echo "Creating Spawn data image..."
echo

pagilaImageName=$(spawnctl create data-image --file ./pagila-backup.yaml --lifetime 336h --accessToken "$SPAWNCTL_ACCESS_TOKEN" -q)

echo "Successfully created Spawn data image '$pagilaImageName'"
echo
echo "Successfully backed up Pagila database"
