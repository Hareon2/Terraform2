provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "" // Bucket where to SAVE Terraform State
    key    = ""             // Object name in the bucket to SAVE Terraform State
    region = ""                                 // Region where bycket created
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "" // Bucket from where to GET Terraform State
    key    = ""             // Object name in the bucket to GET Terraform state
    region = ""                                 // Region where bycket created
  }
}