#!/bin/bash

set -e

echo "Downloading and installing spawnctl..."
curl -sL https://run.spawn.cc/install | sh
export PATH=$HOME/.spawnctl/bin:$PATH

export SPAWN_PAGILA_IMAGE_NAME=Pagila:prod

echo "Creating Pagila backup Spawn data container from image '$SPAWN_PAGILA_IMAGE_NAME'..."
pagilaContainerName=$(spawnctl create data-container --image $SPAWN_PAGILA_IMAGE_NAME --lifetime 10m --accessToken $SPAWNCTL_ACCESS_TOKEN -q)

pagilaJson=$(spawnctl get data-container $pagilaContainerName -o json)
pagilaHost=$(echo $pagilaJson | jq -r '.host')
pagilaPort=$(echo $pagilaJson | jq -r '.port')
pagilaUser=$(echo $pagilaJson | jq -r '.user')
pagilaPassword=$(echo $pagilaJson | jq -r '.password')

echo "Successfully created Spawn data container '$pagilaContainerName'"

docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/pagila" -user=$pagilaUser -password=$pagilaPassword

echo "Successfully migrated 'Pagila' database"

spawnctl delete data-container $pagilaContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

echo "Successfully cleaned up the Spawn data container '$pagilaContainerName'"