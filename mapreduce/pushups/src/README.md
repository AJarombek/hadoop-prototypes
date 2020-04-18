### Overview

Source code for a MapReduce Java/Gradle project that computes the number of days a certain set of pushups are done.

### Files

| Filename                    | Description                                                                          |
|-----------------------------|--------------------------------------------------------------------------------------|
| `PushupsDriver.java`        | Sets up and starts the MapReduce program.                                            |
| `PushupsMapper.java`        | Contains the `map()` method of the MapReduce program.                                |
| `PushupsPartitioner.java`   | Decides which reducer runs the reduce() task for a given data set.                   |
| `PushupsReducer.java`       | Contains the `reduce()` method of the MapReduce program.                             |