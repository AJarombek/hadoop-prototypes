#!/usr/bin/env bash

# Generate a key to connect to the Jenkins ec2 instance.
# This script must execute BEFORE the instance is created.
#
# NOTE: When executed with Terraform, make sure the script has super user privileges.
# Run the command `sudo -s` beforehand.
#
# Author: Andrew Jarombek
# Date: 3/27/2020

bash <(curl -s https://global.jarombek.io/aws-key-gen.sh) $1