terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }

  backend "s3"{
  bucket = "devopsprocloud-remote-state-prod"
  key = "roboshop-infra-vpc"
  region = "us-east-1"
  dynamodb_table = "devopsprocloud-remote-state-lock-prod"
}
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
