resource "aws_autoscaling_group" "my_Ubuntu_server" {
  name                 = "ASG"
  launch_configuration = aws_launch_configuration.my_Ubuntu_server.name
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_default_subnet.default-az1.id, aws_default_subnet.default-az2.id]
  load_balancers       = [aws_elb.my_Ubuntu_server.name]
  max_size             = 3
  min_size             = 1
  min_elb_capacity     = 1

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG"
      Owner  = "Har3on"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
