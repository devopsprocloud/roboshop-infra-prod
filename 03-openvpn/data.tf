data "aws_ami" "rhel-9"{
    owners = ["973714476881"]
    most_recent = true

    filter {
        name = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }   

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "openvpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/openvpn_sg_id"
}

data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnet" "default_vpc_subnet" {
    vpc_id = data.aws_vpc.default_vpc.id
    availability_zone = "us-east-1a"
}

data "aws_ami" "centos8"{
    owners = ["973714476881"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["Centos-8-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}
