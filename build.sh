#!/usr/bin/env bash

TAG="php"

cd "$(dirname "${BASH_SOURCE[0]}")"

docker build  -t indexing/$TAG . --network=host
#docker build --build-arg http_proxy=http://10.10.5.55:3128 -t indexing/$TAG .
docker push indexing/$TAG
