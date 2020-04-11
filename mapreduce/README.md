### Overview

Code specific to the Hadoop data storage and processing platform.

### Commands

```bash
javac -classpath `/usr/lib/hadoop/bin/hadoop classpath` \
    RunningLogDriver.java RunningLogMapper.java RunningLogReducer.java
    
jar cvf mapreduce.jar RunningLogDriver.class RunningLogMapper.class RunningLogReducer.class

rm *.class
hadoop fs -rm -r /test/locations

# Run the MapReduce job.
hadoop jar mapreduce.jar RunningLogDriver -D mapreduce.job.reduces=2 /test/runs /test/locations

# Check if the MapReduce job was successful.
hadoop fs -ls /test/locations
hadoop fs -tail /test/locations/part-r-00000
```

### Files

| Filename          | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `pushups`         | Code specific to a Hadoop MapReduce job for pushup totals per month.        |
| `runninglocation` | Code specific to a Hadoop MapReduce job for miles run at given locations.   |
| `commands.sh`     | Bash commands to run MapReduce jobs.                                        |

### Resources

1) [Copy Jar File Gradle](https://stackoverflow.com/a/30637192)
2) [Hadoop 3.2.1 Documentation](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)