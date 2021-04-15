#!/bin/bash

BEFORE_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

set -e

latest_migrated_version=$(docker run --net=host --rm -e PGPASSWORD=$pagilaPassword postgres:12-alpine psql -h $pagilaHost -p $pagilaPort -U $pagilaUser -d pagila --tuples-only -c "SELECT version FROM flyway_schema_history WHERE script LIKE 'V%' ORDER BY installed_rank DESC LIMIT 1" | xargs)

case $latest_migrated_version in
  1.012)
    echo
    echo 'Running 1.012->1.013 migration test BEFORE action'
    echo
    source $BEFORE_SCRIPT_DIR/V1_013.sh
    v1_013_before
    ;;
esac