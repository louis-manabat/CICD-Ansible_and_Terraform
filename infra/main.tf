provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "rmit-tfstate-ucxqew"
    dynamodb_table = "RMIT-locktable-ucxqew"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
  }
}