#!/usr/bin/env bash

# Bootstrap code for the EMR cluster.  Runs as part of the clusters bootstrap_action.
# Author: Andrew Jarombek
# Date: 3/28/2020

mkdir /var/lib/accumulo
ACCUMULO_HOME='/var/lib/accumulo'
export ACCUMULO_HOME

# Get the create.sql file from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key sqoop/create.sql /home/hadoop/create.sql
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/mapreduce-1.0.jar /home/hadoop/mapreduce-1.0.jar

# Get the RunningLog MapReduce job files from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/RunningLogDriver.java \
    /home/hadoop/RunningLogDriver.java
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/RunningLogMapper.java \
    /home/hadoop/RunningLogMapper.java
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/RunningLogReducer.java \
    /home/hadoop/RunningLogReducer.java

# Get the Pushups MapReduce job files from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/PushupsDriver.java \
    /home/hadoop/PushupsDriver.java
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/PushupsMapper.java \
    /home/hadoop/PushupsMapper.java
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/PushupsReducer.java \
    /home/hadoop/PushupsReducer.java
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/PushupsPartitioner.java \
    /home/hadoop/PushupsPartitioner.java

# Get the Run Length MapReduce Streaming API job files from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/RunLengthMapper.py \
    /home/hadoop/RunLengthMapper.py
aws s3api get-object --bucket hadoop-prototypes-assets --key mapreduce/RunLengthReducer.py \
    /home/hadoop/RunLengthReducer.py
