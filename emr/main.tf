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
  applications = ["Hadoop", "Pig", "Hive", "Spark"]
  service_role = aws_iam_role.emr-access-role.arn

  master_instance_group {
    instance_type = "m1.medium"
  }

  core_instance_group {
    instance_type = "c1.medium"
    instance_count = 1
  }

  ec2_attributes {
    instance_profile = aws_iam_instance_profile.emr-prototype-profile.arn
    key_name = "emr-prototype-key"

    emr_managed_master_security_group = aws_security_group.emr-security-group.id
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

resource "aws_iam_instance_profile" "emr-prototype-profile" {
  name = "emr_prototype_profile"
  role = aws_iam_role.emr-access-role.name
}

resource "aws_security_group" "emr-security-group" {
  name = "emr-security-group"

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}