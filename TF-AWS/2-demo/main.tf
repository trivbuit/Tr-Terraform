
terraform {
  backend "remote" {
    hostname = "trivbuit.scalr.io"
    organization = "env-tct37d1oddo7u4g"

    workspaces {
      name = "Local2Scalr"
    }
  }
}

module "ec2_cluster" {
  source = "github.com/trivbuit/trModule-Terraform-AWS-EC2-Instance?ref=v1.0.4"

  count = 3

  ami           = "ami-0f86a70488991335e"
  instance_type = "t2.micro"

  key_name = "trbvm"
}