### Overview

Currently there is a single container for creating a pseudo-distributed Hadoop cluster.

### Commands

```bash
# Create the cluster.
docker image build -t hadoop-basic-cluster:latest -f Dockerfile .
docker container run -d --name hadoop-basic-cluster -p 80:8080 hadoop-basic-cluster:latest

# Connect to the running cluster.
docker exec -it hadoop-basic-cluster /bin/bash

# Destroy the cluster.
docker container stop hadoop-basic-cluster
docker container rm hadoop-basic-cluster
```

### Files

| Filename            | Description                                                                             |
|---------------------|-----------------------------------------------------------------------------------------|
| `cluster-files`     | Files to place on the container (single node cluster).                                  |
| `commands.sh`       | Commands to execute on the running cluster.                                             |
| `Dockerfile`        | Blueprint for the Docker image holding a pseudo-distributed Hadoop cluster.             |
| `hadoop-init.sh`    | Bootstrapping Bash code to run when the cluster starts.                                 |
| `setup.sh`          | Bash commands to setup the container.                                                   |