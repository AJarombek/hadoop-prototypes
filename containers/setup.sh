#!/usr/bin/env bash

# Setup docker environments for running Hadoop environments.
# Author: Andrew Jarombek
# Date: 2/9/2020

docker image build -t hadoop-basic-cluster:latest -f Dockerfile .
docker container run -d --name hadoop-basic-cluster -p 80:8080 hadoop-basic-cluster:latest
docker container stop hadoop-basic-cluster
docker container rm hadoop-basic-cluster

docker exec -it hadoop-basic-cluster /bin/bash

docker image ls
docker container ls -a