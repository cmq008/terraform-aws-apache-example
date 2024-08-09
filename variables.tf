variable "vpc_id" {
  type = string
  description = "The ID of the VPC where resources will be deployed. Ensure this is the correct VPC ID from your AWS Account."
}

variable "my_ip_with_cidr" {
  type = string
  description = "Your public IP address with CIDR notation to allow SSH access to the instance. Example format: 104.194.51.113/32."
}

variable "public_key" {
  type = string
  description = "The SSH public key to be added to the EC2 instance for remote access. This should be in the standard OpenSSH format."
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
  description = "The type of EC2 instance to launch. Choose from AWS-supported instance types (e.g., t2.micro, t2.large) based on your requirements."
}

variable "server_name" {
  type    = string
  default = "Apache Example Server"
  description = "A descriptive name for the server, used for identification purposes in logs and reports."
}
