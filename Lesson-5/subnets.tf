resource "aws_default_subnet" "default-az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "default-az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}