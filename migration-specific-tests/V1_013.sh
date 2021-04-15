#!/bin/bash

function v1_013_before() {
  docker pull postgres:12-alpine > /dev/null 2>&1
  docker run --net=host --rm -e PGPASSWORD=$pagilaPassword postgres:12-alpine psql -h $pagilaHost -p $pagilaPort -U $pagilaUser -d pagila --tuples-only -c "SELECT actor_id, concat_ws(' ', first_name, last_name) FROM actor" > actors_before.txt
}

function v1_013_after() {
  docker pull postgres:12-alpine > /dev/null 2>&1
  docker run --net=host --rm -e PGPASSWORD=$pagilaPassword postgres:12-alpine psql -h $pagilaHost -p $pagilaPort -U $pagilaUser -d pagila --tuples-only -c "SELECT actor_id, concat_ws(' ', rtrim(concat_ws(' ', first_name, middle_name), ' '), last_name) FROM actor" > actors_after.txt
}

function v1_013_test() {
  if ! diff -q actors_before.txt actors_after.txt > /dev/null ; then
    echo
    echo 'Migration v1_013 produced unexpected results. Diff:'
    diff actors_before.txt actors_after.txt
    echo
    return 1
  fi
  return 0
}
