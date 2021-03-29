
module "ec2_cluster" {
  source = "github.com/trivbuit/trModule-Terraform-AWS-EC2-Instance?ref=v1.0.4"

  count = 1

  ami           = "ami-0f86a70488991335e"
  instance_type = "t2.micro"

  key_name = "trbvm"
}