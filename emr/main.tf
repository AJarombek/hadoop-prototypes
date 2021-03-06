/**
 * EMR Hadoop cluster for prototyping
 * Author: Andrew Jarombek
 * Date: 2/2/2020
 */

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "andrew-jarombek-terraform-state"
    encrypt = true
    key = "sandbox/hadoop-prototypes/emr"
    region = "us-east-1"
  }
}

#-----------------------
# Existing AWS Resources
#-----------------------

#--------------------------------------
# Executed Before Resources are Created
#--------------------------------------

resource "null_resource" "key-gen" {
  provisioner "local-exec" {
    command = "bash key-gen.sh emr-prototype-key"
  }
}

#----------------------
# EMR Cluster Resources
#----------------------

resource "aws_emr_cluster" "prototype-cluster" {
  name = "hadoop-prototypes-cluster"
  release_label = "emr-5.29.0"
  applications = ["Hadoop", "Pig", "Hive", "Hue", "Spark", "Sqoop", "HBase"]
  service_role = aws_iam_role.emr-cluster-access-role.arn

  master_instance_group {
    instance_type = "m5.2xlarge"
  }

  core_instance_group {
    instance_type = "c5.2xlarge"
    instance_count = 1
  }

  ec2_attributes {
    instance_profile = aws_iam_instance_profile.emr-ec2-profile.arn
    key_name = "emr-prototype-key"

    emr_managed_master_security_group = aws_security_group.emr-security-group.id
    emr_managed_slave_security_group = aws_security_group.emr-security-group.id
  }

  termination_protection = false
  log_uri = null

  configurations_json = file("configurations.json")

  bootstrap_action {
    name = "cluster-setup"
    path = "s3://hadoop-prototypes-assets/bootstrap.sh"
  }

  tags = {
    Name = "sandbox-hadoop-prototypes-cluster"
    Environment = "sandbox"
  }

  depends_on = [
    aws_s3_bucket.hadoop-prototypes-assets,
    aws_s3_bucket_object.create-sql,
    aws_s3_bucket_object.bootstrap-sh
  ]
}

resource "aws_iam_role" "emr-cluster-access-role" {
  name = "emr-cluster-access-role"
  path = "/sandbox/hadoop-prototypes/"
  assume_role_policy = file("emr_assume_role_policy.json")
}

resource "aws_iam_role" "emr-ec2-access-role" {
  name = "emr-ec2-access-role"
  path = "/sandbox/hadoop-prototypes/"
  assume_role_policy = file("ec2_assume_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "emr-cluster-access-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
  role = aws_iam_role.emr-cluster-access-role.name
}

resource "aws_iam_role_policy_attachment" "emr-ec2-access-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
  role = aws_iam_role.emr-ec2-access-role.name
}

resource "aws_iam_instance_profile" "emr-ec2-profile" {
  name = "emr_prototype_profile"
  role = aws_iam_role.emr-ec2-access-role.name
}

resource "aws_security_group" "emr-security-group" {
  name = "emr-security-group"

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "hadoop-prototypes-assets" {
  bucket = "hadoop-prototypes-assets"
  acl = "private"
  policy = file("s3_policy.json")

  versioning {
    enabled = false
  }

  tags = {
    Name = "hadoop-prototypes-assets"
    Application = "hadoop-prototypes"
    Environment = "all"
  }
}

/* EMR cluster files */

resource "aws_s3_bucket_object" "bootstrap-sh" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "bootstrap.sh"
  source = "cluster-files/bootstrap.sh"
  etag = filemd5("${path.cwd}/cluster-files/bootstrap.sh")
  content_type = "application/octet-stream"
}

/* Sqoop/MySQL files */

resource "aws_s3_bucket_object" "create-sql" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "sqoop/create.sql"
  source = "cluster-files/create.sql"
  etag = filemd5("${path.cwd}/cluster-files/create.sql")
  content_type = "application/sql"
}

/* Java Hadoop MapReduce files */

resource "aws_s3_bucket_object" "runninglocation-1-0-jar" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/runninglocation-1.0.jar"
  source = "cluster-files/runninglocation-1.0.jar"
  etag = filemd5("${path.cwd}/cluster-files/runninglocation-1.0.jar")
  content_type = "application/java-archive"
}

resource "aws_s3_bucket_object" "running-log-driver-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/RunningLogDriver.java"
  source = "cluster-files/RunningLogDriver.java"
  etag = filemd5("${path.cwd}/cluster-files/RunningLogDriver.java")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "running-log-mapper-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/RunningLogMapper.java"
  source = "cluster-files/RunningLogMapper.java"
  etag = filemd5("${path.cwd}/cluster-files/RunningLogMapper.java")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "running-log-reducer-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/RunningLogReducer.java"
  source = "cluster-files/RunningLogReducer.java"
  etag = filemd5("${path.cwd}/cluster-files/RunningLogReducer.java")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "pushups-driver-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/PushupsDriver.java"
  source = "cluster-files/PushupsDriver.java"
  etag = filemd5("${path.cwd}/cluster-files/PushupsDriver.java")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "pushups-mapper-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/PushupsMapper.java"
  source = "cluster-files/PushupsMapper.java"
  etag = filemd5("${path.cwd}/cluster-files/PushupsMapper.java")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "pushups-partitioner-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/PushupsPartitioner.java"
  source = "cluster-files/PushupsPartitioner.java"
  etag = filemd5("${path.cwd}/cluster-files/PushupsPartitioner.java")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "pushups-reducer-java" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/PushupsReducer.java"
  source = "cluster-files/PushupsReducer.java"
  etag = filemd5("${path.cwd}/cluster-files/PushupsReducer.java")
  content_type = "text/plain"
}

/* Python Hadoop Streaming API files */

resource "aws_s3_bucket_object" "run-length-mapper-py" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/RunLengthMapper.py"
  source = "cluster-files/RunLengthMapper.py"
  etag = filemd5("${path.cwd}/cluster-files/RunLengthMapper.py")
  content_type = "text/plain"
}

resource "aws_s3_bucket_object" "run-length-reducer-py" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/RunLengthReducer.py"
  source = "cluster-files/RunLengthReducer.py"
  etag = filemd5("${path.cwd}/cluster-files/RunLengthReducer.py")
  content_type = "text/plain"
}

/* Apache Pig files */

resource "aws_s3_bucket_object" "longer-runs-pig" {
  bucket = aws_s3_bucket.hadoop-prototypes-assets.id
  key = "mapreduce/longer_runs.pig"
  source = "cluster-files/longer_runs.pig"
  etag = filemd5("${path.cwd}/cluster-files/longer_runs.pig")
  content_type = "text/plain"
}