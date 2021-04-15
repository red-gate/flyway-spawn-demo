#!/bin/bash

set -e

echo "Downloading and installing spawnctl..."
curl -sL https://run.spawn.cc/install | sh
export PATH=$HOME/.spawnctl/bin:$PATH

echo "Backing up Pagila database..."

mkdir backups

docker run --net=host --rm -v $PWD/backups:/backups/ -e PGPASSWORD=$PAGILA_PASSWORD postgres:12-alpine pg_dump -h $PAGILA_HOST -p 5432 -U $PAGILA_USERNAME --create pagila --file /backups/pagila.sql


echo "Creating Spawn data image..."

pagilaImageName=$(spawnctl create data-image --file ./pagila-backup.yaml --lifetime 336h --accessToken $SPAWNCTL_ACCESS_TOKEN -q)

echo "Successfully created Spawn data image '$pagilaImageName'"
echo "Successfully backed up Pagila database"