### Overview

Apache Pig is a higher-level alternative to writing MapReduce applications in Java or with another programming language 
using the Hadoop Streaming API.  Pig files are written in PigLatin, a custom language for Apache Pig.  Behind the 
scenes, Apache Pig converts PigLatin to Java to execute MapReduce functions (similar to Sqoop which generates Java 
files to move data into HDFS).