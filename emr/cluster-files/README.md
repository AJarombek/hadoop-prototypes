### Overview

Files which belong on the EMR cluster's master node.  In order to get on the master node EC2 instance, they are first 
placed in an S3 bucket and then downloaded.

### Files

| Filename                   | Description                                                                             |
|----------------------------|-----------------------------------------------------------------------------------------|
| `bootstrap.sh`             | Bash script that runs when the master node is initially booted up.                      |
| `create.sql`               | SQL script to initialize data in the master node's MySQL database instance.             |