provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "rmit-tfstate-3i9yqb"
    dynamodb_table = "RMIT-locktable-3i9yqb"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
  }
}