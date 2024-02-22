variable "stage" {
  default = {
    "normal" = "t2.micro"
    "prod"   = "t4.micro"
    "dev"    = "t4.micro"
  }
}

variable "env" {
  default = "no name"
}
variable "env1" {
  default = "dev"
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}