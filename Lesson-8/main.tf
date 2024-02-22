provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = var.env == "prod" ? var.stage["prod"] : var.stage["normal"]  ## conditions

  tags = {
    Name = "prod"  # Имя, которое вы хотите присвоить экземпляру
  }
}

resource "aws_instance" "webserver" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = lookup(var.stage,var.env1 )

  tags = {
    Name = "prod"  # Имя, которое вы хотите присвоить экземпляру
  }
}

resource "aws_security_group" "my_webserver" {
  name   = "Dynamic Security Group"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Denis Astahov"
  }
}