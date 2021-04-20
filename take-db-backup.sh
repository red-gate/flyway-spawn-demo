#!/bin/bash

set -e

echo "Downloading and installing spawnctl..."
curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
export PATH=$HOME/.spawnctl/bin:$PATH
echo "spawnctl successfully installed"

databaseName="pagila"
mkdir backups

docker pull postgres:12-alpine > /dev/null 2>&1

echo
echo "Backing up Pagila database..."

docker run --net=host --rm -v $PWD/backups:/backups/ -e PGPASSWORD=$PAGILA_PASSWORD postgres:12-alpine pg_dump -h $PAGILA_HOST -p 5432 -U $PAGILA_USERNAME --create $databaseName --file /backups/pagila.sql

echo "Creating Spawn data image..."
echo

pagilaImageName=$(spawnctl create data-image --file ./pagila-backup.yaml --lifetime 336h --accessToken $SPAWNCTL_ACCESS_TOKEN -q)

echo "Successfully created Spawn data image '$pagilaImageName'"
echo
echo "Successfully backed up Pagila database"