### Overview

Code specific to the Hadoop data storage and processing platform.

### Commands

```bash
javac -classpath `/usr/lib/hadoop/bin/hadoop classpath` \
    RunningLogDriver.java RunningLogMapper.java RunningLogReducer.java
    
jar cvf mapreduce.jar RunningLogDriver.class RunningLogMapper.class RunningLogReducer.class

javac -classpath `/usr/lib/hadoop/bin/hadoop classpath` \
    PushupsDriver.java PushupsMapper.java PushupsReducer.java PushupsPartitioner.java
    
jar cvf mapreduce2.jar PushupsDriver.class PushupsMapper.class PushupsReducer.class PushupsPartitioner.class

rm *.class
hadoop fs -rm -r /test/locations
hadoop fs -rm -r /test/pushups
hadoop fs -rm -r /test/lengths

# Run the first MapReduce job.
hadoop jar mapreduce.jar RunningLogDriver -D mapreduce.job.reduces=2 /test/runs /test/locations

# Check if the first MapReduce job was successful.
hadoop fs -ls /test/locations
hadoop fs -tail /test/locations/part-r-00000

# Run the second MapReduce job.
hadoop jar mapreduce2.jar PushupsDriver -D mapreduce.job.reduces=2 /test/core /test/pushups

# Check if the first MapReduce job was successful.
hadoop fs -ls /test/pushups

# March results.
hadoop fs -tail /test/pushups/part-r-00000

# April results.
hadoop fs -tail /test/pushups/part-r-00000

# Run a Hadoop Streaming API job
hadoop jar /usr/lib/hadoop/hadoop-streaming.jar \
    -
    -input /test/runs \
    -output /test/lengths \
    -mapper RunLengthMapper.py \
    -reducer RunLengthReducer.py \
    -file RunLengthMapper.py \
    -file RunLengthReducer.py

hadoop fs -ls /test/lengths
hadoop fs -tail /test/lengths/part-00000
hadoop fs -tail /test/lengths/part-00001
hadoop fs -tail /test/lengths/part-00002
```

### Files

| Filename          | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `pushups`         | Code specific to a Hadoop MapReduce job for pushup totals per month.        |
| `runlength`       | Code specific to a Hadoop MapReduce Streaming API job for run lengths.      |
| `runninglocation` | Code specific to a Hadoop MapReduce job for miles run at given locations.   |
| `commands.sh`     | Bash commands to run MapReduce jobs.                                        |

### Resources

1) [Copy Jar File Gradle](https://stackoverflow.com/a/30637192)
2) [Hadoop 3.2.1 Documentation](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)