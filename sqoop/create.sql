/**
 * DDL and DML statements for SQLite.  This data will eventually be moved to HDFS using Sqoop.
 * Author: Andrew Jarombek
 * Date: 3/28/2020
 */

CREATE TABLE runs (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    date TEXT NOT NULL,
    miles REAL NOT NULL,
    minutes INTEGER,
    seconds INTEGER
    description TEXT
);

CREATE TABLE core (
    id INTEGER PRIMARY KEY,
    date TEXT NOT NULL,
    pushups INTEGER NOT NULL,
    minutes INTEGER NOT NULL
);