
resource "aws_instance" "web" {
  ami           = "ami-0f86a70488991335e"
  instance_type = "t2.micro"

  key_name = "trbvm"

  tags = {
    Name = "Demo Scalr"
  }
}

output "login" {
  value = aws_instance.web.public_ip
}