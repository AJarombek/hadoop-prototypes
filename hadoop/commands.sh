#!/usr/bin/env bash

# Working with MapReduce and Java on the EMR Cluster.
# Author: Andrew Jarombek
# Date: 4/11/2020

hadoop version

# Extract the class files in the jar file for debugging
jar -xf mapreduce-1.0.jar

hadoop jar mapreduce-1.0.jar RunningLogDriver -D mapreduce.job.reduces=2 test/runs test/locations
