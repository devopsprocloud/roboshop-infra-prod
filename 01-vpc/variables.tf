variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "project_name" {
  type = string 
  default = "roboshop"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "common_tags" {
  type = map 
  default = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "public_subnets_cidr" {
  type = list 
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnets_cidr" {
  type = list 
  default = ["10.1.11.0/24", "10.1.12.0/24"]
}

variable "database_subnets_cidr" {
  type = list 
  default = ["10.1.21.0/24", "10.1.22.0/24"]
}

variable "is_peering_required" {
  type = bool
  default = true
}