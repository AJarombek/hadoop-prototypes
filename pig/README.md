### Overview

Apache Pig is a higher-level alternative to writing MapReduce applications in Java or with another programming language 
using the Hadoop Streaming API.  Pig files are written in PigLatin, a custom language for Apache Pig.  Behind the 
scenes, Apache Pig converts PigLatin to Java to execute MapReduce functions (similar to Sqoop which generates Java 
files to move data into HDFS).

### Files

| Filename                | Description                                                                             |
|-------------------------|-----------------------------------------------------------------------------------------|
| `longer_runs.pig`       | Pig program which filters longer runs.                                                  |
| `short_run_count.pig`   | Pig program which counts the number of short runs.                                      |