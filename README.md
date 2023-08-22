Terraform module EC2 Instance with Apache

```hcl
terraform {

}

provider "aws" {
  region = "us-east-1"
}

module "apache" {
  source          = ".//terraform-aws-apache-example"
  vpc_id          = "vpc-000000"
  my_ip_with_cidr = "MY_PUBLIC_IP/32"
  public_key      = "ssh-rsa ......"
  instance_type   = "t2.micro"
  server_name     = "Apache Example Server"
}

output "public_ip" {
  value = module.apache.public_ip
}

```
