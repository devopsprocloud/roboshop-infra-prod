variable "common_tags" {
  type = map 
  default = {
    Project = "roboshop"
    Environment = "prod"
    Terraform = "true"
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "prod"
}