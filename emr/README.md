### Overview

EMR Cluster for running Hadoop Ecosystem applications.  Infrastructure is built with Terraform.

### Commands

Build the Infrastructure with Terraform.

```bash
sudo -s
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
```

Connect to the master node of the EMR cluster (an EC2 instance).

```bash
# Replace 'xx-xx-xx-xx' with the IP address of the cluster's master node.
ssh -i ~/Documents/emr-prototype-key.pem -o IdentitiesOnly=yes hadoop@ec2-xx-xx-xx-xx.compute-1.amazonaws.com
```

### Files

| Filename                      | Description                                                                             |
|-------------------------------|-----------------------------------------------------------------------------------------|
| `cluster-files`               | Files to place on an EMR cluster and an S3 bucket.                                      |
| `configurations.json`         | Configurations for Hadoop and Spark on EMR.                                             |
| `ec2_assume_role_policy.json` | IAM Assume Role Policy for an EC2 Instance (Cluster Instance).                          |
| `emr_assume_role_policy.json` | IAM Assume Role Policy for an EMR Cluster.                                              |
| `key-gen.sh`                  | Generate a public and private SSH Key to connect to the cluster.                        |
| `main.tf`                     | Main Terraform script for the EMR infrastructure.                                       |
| `s3_policy.json`              | IAM Policy for the S3 bucket containing files to be placed on the EMR cluster.          |

### Resources

1) [IAM Role for EMR Cluster](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role.html)
2) [IAM Role for EMR EC2 Instances](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-iam-role-for-ec2.html)
3) [EMR Cluster Terraform Docs](https://www.terraform.io/docs/providers/aws/r/emr_cluster.html)
4) [EMR Instance Pricing](https://aws.amazon.com/emr/pricing/)