data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnet_ids.ids)
  id       = each.value
}


resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "Permitir trafico entrante SSH y HTTP"
  vpc_id      = data.aws_vpc.main.id

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [var.my_ip_with_cidr]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    description      = "Trafico saliente"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
}

resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = var.public_key
}

data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "CloudInit" {
  ami                    = data.aws_ami.amazon-linux-2.id
  subnet_id              = tolist(data.aws_subnets.subnet_ids.ids)[0]
  instance_type          = var.instance_type
  key_name               = aws_key_pair.terraform.key_name
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = var.server_name
  }

}
