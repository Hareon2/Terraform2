provider "aws" {
  region     = "us-east-1"
}
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_Ubuntu.id  ## lesson-6
}
resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "my_Ubuntu" {
  ami                    = "ami-06aa3f7caf3a30282"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags                   = {
    Name                 = "prod"  # Имя, которое вы хотите присвоить экземпляру
  }

  user_data_replace_on_change = true

  user_data = templatefile("./user_data.sh.tpl", {
    f_name = "Yura",
    nickname = "har3on",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })

  lifecycle {  ## 6-Lesson
    create_before_destroy = true ## almost zero downtime
    ## Так же есть prevent_destroy - невозможно удалить, ignore_changes[ami,...атрибуты в aws_instance]
  }
}

resource "aws_security_group" "my_webserver" {
    vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id
    name = "WebServer SG"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
