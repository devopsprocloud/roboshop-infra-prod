variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "tags" {
  default = {
    Component = "acn"
  }
}

variable "zone_name" {
  default = "devopsprocloud.in"

}