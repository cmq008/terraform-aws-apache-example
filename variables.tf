variable "vpc_id" {
  type = string
  description = "Provide your VPC ID from your AWS Account"
}

variable "my_ip_with_cidr" {
  type = string
  description = "Provide your IP eg. 104.194.51.113/32"
}

variable "public_key" {
  type = string
  description = "Provide your Public Key for the instance"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
  description = "Provide your type of instance"
}

variable "server_name" {
  type = string
  default = "Apache Example Server"
  description = "Provide your name of server"
}
