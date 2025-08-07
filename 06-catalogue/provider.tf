terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }

  backend "s3"{
  bucket = "devopsprocloud-remote-state-dev"
  key = "roboshop-infra-catalogue-1"
  region = "us-east-1"
  dynamodb_table = "devopsprocloud-remote-state-lock-dev"
}
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}