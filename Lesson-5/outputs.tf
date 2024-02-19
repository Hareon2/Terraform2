output "latest_ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.ubuntu.name
}