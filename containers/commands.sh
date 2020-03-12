#!/usr/bin/env bash

# Commands to run on the Hadoop cluster.
# Author: Andrew Jarombek
# Date: 3/10/2020

# I hope you realize how wonderful and sweet you are.

# Check the custom config
cd /etc/hadoop/conf
ls -ltr
more core-site.xml
more hdfs-site.xml
more mapred-site.xml
more yarn-site.xml

# Run the following commands from HADOOP_HOME using the hdfs user
cd ${HADOOP_HOME}

# Check running Java processes.
jps

# Run a built-in sample Hadoop MapReduce job
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar pi 16 1000

# List the NameNodes in the cluster.  For the pseudo-distributed cluster, this should return localhost
hdfs getconf -namenodes

# There are no secondary name nodes.
hdfs getconf -secondaryNameNodes

# See available hadoop fs commands:
hadoop fs

# HDFS virtual filesystem equivalent to the unix 'ls' command.
hadoop fs -ls

# These two commands are equivalent.  They both upload a CSV file into HDFS.
hadoop fs -mkdir /data
hadoop fs -mkdir /data/exercise
hadoop fs -copyFromLocal usr/andy/march-exercise-data.csv /data/exercise

# Or use this equivalent command:
hdfs dfs -put usr/andy/march-exercise-data.csv /data/exercise

# View the file just created.
hadoop fs -ls /data/exercise

# This command downloads a file stored on HDFS.
hadoop fs -get /data/exercise/march-exercise-data.csv

hadoop fs -ls /data/exercise
hadoop fs -cat /data/exercise/march-exercise-data.csv
hadoop fs -rm /data/exercise/march-exercise-data.csv