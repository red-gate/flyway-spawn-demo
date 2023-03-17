#!/bin/bash

set -euxo pipefail

aws cloudformation create-stack --stack-name rds-pagila-db \
  --template-body file://postgres.yaml \
  --parameters ParameterKey=DBName,ParameterValue=pagila ParameterKey=DBPassword,ParameterValue="$PGPASSWORD"
