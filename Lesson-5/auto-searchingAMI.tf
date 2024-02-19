provider "aws" {
  region     = "us-east-1"
}

resource "aws_launch_configuration" "my_Ubuntu_server" {
  name_prefix            = "WebServer-Highly-Available"
  image_id               = data.aws_ami.ubuntu.id
  security_groups        = [aws_security_group.my_Ubuntu_server.id]
  instance_type          = "t2.micro"

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



