provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}
resource "aws_instance" "webserver" {
  count = 3
  ami = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
  tags = {
    Name = "Servers number ${count.index + 1}"
  }
}