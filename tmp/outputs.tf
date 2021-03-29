
output "ec2_user" {
  value = ec2_cluster.*.public_ip
}