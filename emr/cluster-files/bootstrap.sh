#!/usr/bin/env bash

# Bootstrap code for the EMR cluster.  Runs as part of the clusters bootstrap_action.
# Author: Andrew Jarombek
# Date: 3/28/2020

mkdir /var/lib/accumulo
ACCUMULO_HOME='/var/lib/accumulo'
export ACCUMULO_HOME

# Get the create.sql file from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key sqoop/create.sql /home/hadoop/create.sql

#wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz
#tar xvzf mysql-connector-java-5.1.48.tar.gz
#cp mysql-connector-java-5.1.48/mysql-connector-java-5.1.48.jar /usr/lib/sqoop/lib/