#!/usr/bin/env bash

TAG="php"

cd "$(dirname "${BASH_SOURCE[0]}")"

docker build -t indexing/$TAG .
docker push indexing/$TAG
