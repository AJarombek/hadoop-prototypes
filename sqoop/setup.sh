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
sqoop help

# Get command specific help with Sqoop
sqoop import --help

# MySQL is already installed on the cluster
sudo mysql

# -----------------
# Begin MySQL Shell
# -----------------

show databases
use test
show tables

source create.sql

# ---------------
# End MySQL Shell
# ---------------

wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz
sudo cp mysql-connector-java-5.1.48/mysql-connector-java-5.1.48.jar /usr/lib/sqoop/lib/

# Check the port MySQL is running on
netstat
netstat -tulpn

sudo sqoop import --connect jdbc:mysql://172.31.23.200:3306/test --table core --m 1 --target-dir /test/core --direct
