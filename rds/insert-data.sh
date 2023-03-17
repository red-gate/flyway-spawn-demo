#!/bin/bash

set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA_DIR=$(dirname "$DIR")/example-backup-file

docker run --net=host --rm -v "$DATA_DIR":/data/ -e PGPASSWORD="$PAGILA_PASSWORD" postgres:15-alpine psql -h "$PAGILA_HOST" -p 5432 -U "$PAGILA_USERNAME" -f /data/pagila.sql -d pagila
