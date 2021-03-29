
# terraform {
#   backend "s3" {
#     bucket     = "rt-tf-test-bucket"
#     key        = "terraform.tfstate"
#     region     = "ap-southeast-1"
#     access_key = "access_key"
#     secret_key = "secret_key"
#   }
# }

terraform {
  backend "remote" {
    hostname = "trivbuit.scalr.io"
    organization = "env-tct37d1oddo7u4g"

    workspaces {
      name = "S3toScalr"
    }
  }
}

module "ec2_cluster" {
  source = "github.com/trivbuit/trModule-Terraform-AWS-EC2-Instance?ref=v1.0.4"

  count = 1

  ami           = "ami-0f86a70488991335e"
  instance_type = "t2.micro"

  key_name = "trbvm"
}