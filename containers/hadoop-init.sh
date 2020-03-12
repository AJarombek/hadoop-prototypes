#!/usr/bin/env bash

# Hadoop commands which run as soon as the container starts.
# Author: Andrew Jarombek
# Date: 3/12/2020

cd /usr/share/hadoop
bin/hdfs namenode -format
service ssh start

# Start ResourceManager, NodeManager, NameNode, SecondaryNameNode, DataNode
sbin/start-dfs.sh
sbin/start-yarn.sh

useradd andy
bin/hadoop fs -mkdir -p /user/andy
bin/hadoop fs -chown andy:andy /user/andy
bin/hadoop fs -mkdir /tmp
bin/hadoop fs -chmod 777 /tmp