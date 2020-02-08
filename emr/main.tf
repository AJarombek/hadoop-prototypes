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

#----------------------
# EMR Cluster Resources
#----------------------

resource "aws_emr_cluster" "prototype-cluster" {
  name = "hadoop-prototypes-cluster"
  release_label = "emr-5.29.0"
  applications = ["Hadoop", "Pig", "Hive", "Spark"]
  service_role = aws_iam_role.emr-access-role.arn

  master_instance_group {
    instance_type = "m1.medium"
  }

  core_instance_group {
    instance_type = "c1.medium"
    instance_count = 1
  }

  termination_protection = false
  log_uri = null

  configurations_json = file("configurations.json")

  tags = {
    Name = "sandbox-hadoop-prototypes-cluster"
    Environment = "sandbox"
  }
}

resource "aws_iam_role" "emr-access-role" {
  name = "emr-access-role"
  path = "/sandbox/hadoop-prototypes/"
  assume_role_policy = file("assume_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "emr-access-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
  role = aws_iam_role.emr-access-role.name
}