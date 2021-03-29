# Configure the AWS Provider
provider "aws" {
  region     = "ap-southeast-1"
}

module "ec2_cluster" {
  source  = "trivbuit.scalr.io/env-tct37d1oddo7u4g/ec2-instance-trmodule/aws"
	version = "1.0.4"

  count = var.instance_count

  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.key_name
}