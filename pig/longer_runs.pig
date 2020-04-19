/*
 * First Apache Pig program which returns the longer runs found in HDFS.
 * Author: Andrew Jarombek
 * Date: 4/19/2020
 */

-- Load running data from HDFS.  The resulting data structure is called a 'bag', which in turn contains tuples with
-- schemas matching the one declared in the 'AS' clause.
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

-- Filter the running data, including only runs greater than 5 miles in the result.
longer_runs = FILTER runs BY miles > 5;

-- Out of all the fields found in tuples inside the 'longer_runs' bag, pick only the 'date' and 'miles' fields.
longer_runs_dates = FOREACH longer_runs GENERATE date, miles;

-- Order the remaining two fields by the 'miles' field.
ordered_longer_runs = ORDER longer_runs_dates BY miles;

-- Ouput the result to stdio (bash terminal).
DUMP ordered_longer_runs;