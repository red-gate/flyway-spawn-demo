#!/bin/bash

set -e

echo "Downloading and installing spawnctl..."
curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
export PATH=$HOME/.spawnctl/bin:$PATH
echo "spawnctl successfully installed"

export SPAWN_PAGILA_IMAGE_NAME=Pagila:prod

echo
echo "Creating Pagila backup Spawn data container from image '$SPAWN_PAGILA_IMAGE_NAME'..."
pagilaContainerName=$(spawnctl create data-container --image $SPAWN_PAGILA_IMAGE_NAME --lifetime 10m --accessToken $SPAWNCTL_ACCESS_TOKEN -q)

pagilaJson=$(spawnctl get data-container $pagilaContainerName -o json)
pagilaHost=$(echo $pagilaJson | jq -r '.host')
pagilaPort=$(echo $pagilaJson | jq -r '.port')
pagilaUser=$(echo $pagilaJson | jq -r '.user')
pagilaPassword=$(echo $pagilaJson | jq -r '.password')

echo "Successfully created Spawn data container '$pagilaContainerName'"
echo

docker pull postgres:12-alpine > /dev/null 2>&1
docker pull flyway/flyway > /dev/null 2>&1

echo
echo "Starting migration of database with flyway"

docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/pagila" -user=$pagilaUser -password=$pagilaPassword

echo "Successfully migrated 'Pagila' database"
echo

spawnctl delete data-container $pagilaContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

echo "Successfully cleaned up the Spawn data container '$pagilaContainerName'"