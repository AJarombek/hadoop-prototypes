#!/usr/bin/env bash

# Bootstrap code for the EMR cluster.  Runs as part of the clusters bootstrap_action.
# Author: Andrew Jarombek
# Date: 3/28/2020

mkdir /var/lib/accumulo
ACCUMULO_HOME='/var/lib/accumulo'
export ACCUMULO_HOME

sudo yum install -y sqlite-devel