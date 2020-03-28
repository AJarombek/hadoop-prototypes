#!/usr/bin/env bash

# Working with Sqoop (SQL to Hadoop) on the EMR Cluster.
# Author: Andrew Jarombek
# Date: 3/27/2020

# SSH into the cluster.  The server IP address/hostname can be found on the AWS Console
# https://console.aws.amazon.com/elasticmapreduce
ssh -i ~/Documents/emr-prototype-key.pem hadoop@ec2-xxx.xxx.xxx.xxx.compute-1.amazonaws.com

# Check the OS Version and Linux distribution (Amazon Linux/Fedora)
cat /etc/os-release

hdfs

# Supress warning about not finding Accumulo when running Sqoop commands.
mkdir /var/lib/accumulo
ACCUMULO_HOME='/var/lib/accumulo'
export ACCUMULO_HOME

sqoop version

# Install SQLite, the database from which Sqoop will ingest data and place it in HDFS
sudo yum install -y sqlite-devel

sqlite3 --version

# Start the SQLite shell
sqlite3

# ------------------
# Begin SQLite Shell
# ------------------

# See available commands
.help

# List all the databases
.databases

.read create.sql

# ----------------
# End SQLite Shell
# ----------------