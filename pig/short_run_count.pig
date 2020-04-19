/*
 * Apache Pig program which returns the number of short runs.
 * Author: Andrew Jarombek
 * Date: 4/19/2020
 */

-- Load running data from HDFS.
runs = LOAD 'runs' USING PigStorage(',') AS (
    id: int,
    name: chararray,
    location: chararray,
    date: chararray,
    miles: double,
    minutes: int,
    seconds: int,
    pace: chararray
);

short_runs = FILTER runs BY miles < 4;

short_runs_group = GROUP short_runs ALL;

short_runs_count = FOREACH short_runs_group GENERATE COUNT(short_runs);

DUMP short_runs_count;