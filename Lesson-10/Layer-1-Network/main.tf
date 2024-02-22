provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "denis-astahov-project-kgb-terraform-state" // Bucket where to SAVE Terraform State
    key    = "dev/network/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}