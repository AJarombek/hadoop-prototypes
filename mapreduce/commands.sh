#!/usr/bin/env bash

# Working with MapReduce and Java on the EMR Cluster.
# Author: Andrew Jarombek
# Date: 4/11/2020

hadoop version

# When making a directory in HDFS, it makes it under the /user/<username>/ directory.
hadoop fs -mkdir testing
hadoop fs -ls /user/
hadoop fs -ls /user/hadoop/

# Extract the class files in the jar file for debugging
jar -xf mapreduce-1.0.jar

# Check Java file contents.
tail -n 50 RunningLogReducer.java

# Or work with the Java files directly, first turning them into a jar.
javac -classpath `/usr/lib/hadoop/bin/hadoop classpath` \
    RunningLogDriver.java RunningLogMapper.java RunningLogReducer.java

jar cvf mapreduce.jar RunningLogDriver.class RunningLogMapper.class RunningLogReducer.class
ls -ltr

rm *.class
hadoop fs -rm -r /test/locations

# Run the MapReduce job.
hadoop jar mapreduce.jar RunningLogDriver -D mapreduce.job.reduces=2 /test/runs /test/locations

# Check if the MapReduce job was successful.
hadoop fs -ls /test/locations
hadoop fs -tail /test/locations/part-r-00000

# Run a Hadoop Streaming API job
hadoop jar /usr/lib/hadoop/hadoop-streaming.jar \
    -input /test/runs \
    -output /test/lengths \
    -mapper RunLengthMapper.py \
    -reducer RunLengthReducer.py \
    -file RunLengthMapper.py \
    -file RunLengthReducer.py