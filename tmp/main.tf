# Configure the AWS Provider
provider "aws" {
  region     = "ap-southeast-1"
}

module "ec2_cluster" {
  source = "github.com/trivbuit/trModule-Terraform-AWS-EC2-Instance?ref=v1.0.4"

  count = var.instance_count

  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.key_name
}