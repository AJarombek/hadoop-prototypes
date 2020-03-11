#!/usr/bin/env bash

# Commands to run on the Hadoop cluster.
# Author: Andrew Jarombek
# Date: 3/10/2020

# I hope you realize how wonderful and sweet you are.

cd ${HADOOP_HOME}

# These two commands are equivalent.  They both upload a CSV file into HDFS.
hadoop fs -copyFromLocal march-exercise-data.csv /data/exercise
hdfs dfs -put march-exercise-data.csv /data/exercise

# This command downloads a file stored on HDFS.
hadoop fs -get /data/exercise/march-exercise-data.csv

hadoop fs -ls /data/exercise
hadoop fs -cat /data/exercise/march-exercise-data.csv
hadoop fs -rm /data/exercise/march-exercise-data.csv