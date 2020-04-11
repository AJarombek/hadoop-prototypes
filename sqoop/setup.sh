#!/usr/bin/env bash

# Working with Sqoop (SQL to Hadoop) on the EMR Cluster.
# Author: Andrew Jarombek
# Date: 3/27/2020

# SSH into the cluster.  The server IP address/hostname can be found on the AWS Console
# https://console.aws.amazon.com/elasticmapreduce
ssh -i ~/Documents/emr-prototype-key.pem hadoop@ec2-xxx.xxx.xxx.xxx.compute-1.amazonaws.com

# Resolves 'too many authentication failures' SSH error.
# https://www.tecmint.com/fix-ssh-too-many-authentication-failures-error/
ssh -i ~/Documents/emr-prototype-key.pem -o IdentitiesOnly=yes hadoop@ec2-xxx.xxx.xxx.xxx.compute-1.amazonaws.com

# Check the OS Version and Linux distribution (Amazon Linux/Fedora)
cat /etc/os-release

hdfs

# Supress warning about not finding Accumulo when running Sqoop commands.
mkdir /var/lib/accumulo
ACCUMULO_HOME='/var/lib/accumulo'
export ACCUMULO_HOME

# Get the create.sql file from S3
aws s3api get-object --bucket hadoop-prototypes-assets --key sqoop/create.sql /home/hadoop/create.sql

sqoop version
sqoop help

# Get command specific help with Sqoop
sqoop import --help

# MySQL is already installed on the cluster
sudo mysql

# -----------------
# Begin MySQL Shell
# -----------------

show databases;
use test
show tables;

source create.sql

# ---------------
# End MySQL Shell
# ---------------

wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz
tar xvzf mysql-connector-java-5.1.48.tar.gz
sudo cp mysql-connector-java-5.1.48/mysql-connector-java-5.1.48.jar /usr/lib/sqoop/lib/

# Check the port MySQL is running on
netstat
netstat -tulpn

# More specifically, only look at port 3306.
sudo netstat -tulpn | grep 3306

# Even more specifically, just the IP and port.
sudo netstat -tulpn | grep 3306 | grep -o '[0-9\.]\+:3306'
sudo netstat -tulpn | grep -o '[0-9\.]\+:3306'
MySQLAddress=$(sudo netstat -tulpn | grep -o '[0-9\.]\+:3306')

# Get the non-master node IP addresses
yarn node -list
yarn node -list | grep -o 'ip-[0-9\-]\+'
yarn node -list | grep -o 'ip-[0-9\-]\+' | grep -m 1 '^ip[0-9\-]\+'
YARNAddress=$(yarn node -list | grep -o 'ip-[0-9\-]\+' | grep -m 1 '^ip[0-9\-]\+')

# Get Just the IP Address
echo ${MySQLAddress::-5}
MySQLAddress=${MySQLAddress::-5}
echo ${MySQLAddress}

echo ${YARNAddress:3}
YARNAddress=${YARNAddress:3}
echo ${YARNAddress}

# Replace the '.' characters with '-'.
echo $(sed 's/\./-/g' <<< ${MySQLAddress})
MySQLAddressDashed=$(sed 's/\./-/g' <<< ${MySQLAddress})
echo ${MySQLAddressDashed}

sed -i "s/{MySQLAddressDashed}/${MySQLAddressDashed}/g" create.sql
sed -i "s/{YARNAddress}/${YARNAddress}/g" create.sql

# Set proper directory permissions for HDFS.
sudo -u hdfs hdfs dfs -chmod 777 /

sudo sqoop import --connect jdbc:mysql://172.31.22.179:3306/test --table core --m 1 --target-dir /test/core --direct
sudo sqoop import --connect jdbc:mysql://172.31.22.179:3306/test --table runs --m 1 --target-dir /test/runs --direct

# Remove an existing directory recursively in HDFS.
hdfs dfs -rm -r /test

hadoop fs -ls /
hadoop fs -ls /test
hadoop fs -ls /test/core