output "public_ip" {
  value = aws_instance.instance.public_ip
  description = "EC2 Public IP"
}
