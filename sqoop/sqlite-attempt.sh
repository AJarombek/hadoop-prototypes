#!/usr/bin/env bash

# Unfortunately, using SQLite with Sqoop was a dead-end.  Sqoop does not work with SQLite, and the JIRA ticket to fix
# the issue is open and five years old.  The attempted commands are listed here for reference.
# Open JIRA Ticket: https://bit.ly/3bNv5QR
# Unresolved Stackoverflow topic: https://stackoverflow.com/questions/30365368/how-to-import-sqlite-database-into-hadoop-hdfs

# Install SQLite, the database from which Sqoop will ingest data and place it in HDFS
sudo yum install -y sqlite-devel

# Get the create.sql file from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key sqoop/create.sql create.sql

sqlite3 --version

# Start the SQLite shell
sqlite3

# Start the SQLite shell and use/create a database.
sqlite3 test.db

# ------------------
# Begin SQLite Shell
# ------------------

# See available commands
.help

# List all the databases and their file location.
.databases

# Execute the SQL script to create tables and insert rows
.read create.sql

# List the tables in the database
.tables

# ----------------
# End SQLite Shell
# ----------------

# Download the SQLite JDBC driver
wget bitbucket.org/xerial/sqlite-jdbc/downloads/sqlite-jdbc-3.30.1.jar

# Move the JDBC driver to the Sqoop installation directory
sudo cp sqlite-jdbc-3.30.1.jar /usr/lib/sqoop/lib/

# Confirm it was copied
cd /usr/lib/sqoop/lib/
ls -ltr

sqoop import --connect jdbc:sqlite:/home/hadoop/test.db --table core --m 1 --target-dir /test/core --driver org.sqlite.JDBC