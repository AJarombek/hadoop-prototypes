### Overview

Python source code which uses the Hadoop Streaming API to execute MapReduce jobs.  Computes the different types of runs 
exercised (based on their length).

### Commands

The following commands copy the Python files to be distributed to the EMR cluster.

```bash
# Assuming the repository is downloaded under the users Documents folder.
cp ~/Documents/hadoop-prototypes/mapreduce/runlength/RunLengthMapper.py \
    ~/Documents/hadoop-prototypes/emr/cluster-files/
    
cp ~/Documents/hadoop-prototypes/mapreduce/runlength/RunLengthReducer.py \
    ~/Documents/hadoop-prototypes/emr/cluster-files/
```

### Files

| Filename                    | Description                                                                          |
|-----------------------------|--------------------------------------------------------------------------------------|
| `RunLengthMapper.java`      | Contains the `map()` method of the MapReduce program.                                |
| `RunLengthReducer.java`     | Contains the `reduce()` method of the MapReduce program.                             |