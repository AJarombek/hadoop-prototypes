#!/usr/bin/env bash

# Working with Sqoop on the EMR Cluster.
# Author: Andrew Jarombek
# Date: 3/27/2020

# SSH into the cluster.  The server IP address/hostname can be found on the AWS Console
# https://console.aws.amazon.com/elasticmapreduce
ssh -i ~/Documents/emr-prototype-key.pem hadoop@ec2-xxx.xxx.xxx.xxx.compute-1.amazonaws.com

hdfs