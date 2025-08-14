module "mongodb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel-9.id
  name = "${local.ec2_name}-mongodb"

  instance_type = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id     = local.database_subnet_id
  create_security_group = false

  tags = merge(var.common_tags,
  {
    Component = "${local.ec2_name}-mongodb"
  }
  )
}

resource "null_resource" "mongodb" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.mongodb.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.mongodb.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}" # We are parsing the variables as $1 (mongodb) and $2 (dev) to bootstrap script
    ]
  }
}

module "redis" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel-9.id
  name = "${local.ec2_name}-redis"

  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id     = local.database_subnet_id
  create_security_group = false

  tags = merge(var.common_tags,
  {
    Component = "${local.ec2_name}-redis"
  }
  )
}

resource "null_resource" "redis" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.redis.id 
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.redis.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}" # We are parsing the variables as $1 (mongodb) and $2 (dev) to bootstrap script
    ]
  }
}

module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel-9.id
  name = "${local.ec2_name}-mysql"

  instance_type = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id     = local.database_subnet_id
  create_security_group = false
  iam_instance_profile = "EC2-Role-For-Shell-Script" # providing this IAM role to the instance to fetch the values from Parameter store

  tags = merge(var.common_tags,
  {
    Component = "${local.ec2_name}-mysql"
  }
  )
}

resource "null_resource" "mysql" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.mysql.id 
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.mysql.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}" # We are parsing the variables as $1 (mongodb) and $2 (dev) to bootstrap script
    ]
  }
}

module "rabbitmq" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel-9.id
  name = "${local.ec2_name}-rabbitmq"

  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id     = local.database_subnet_id
  create_security_group = false
  iam_instance_profile = "EC2-Role-For-Shell-Script"

  tags = merge(var.common_tags,
  {
    Component = "${local.ec2_name}-rabbitmq"
  }
  )
}

resource "null_resource" "rabbitmq" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.rabbitmq.id 
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.rabbitmq.private_ip
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}" # We are parsing the variables as $1 (mongodb) and $2 (dev) to bootstrap script
    ]
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = "devopsprocloud.in"

  records = [
    {
      name    = "mongodb-${var.environment}"
      type    = "A"
      ttl     = 1
      records = ["${module.mongodb.private_ip}"]
    },
    {
      name    = "redis-${var.environment}"
      type    = "A"
      ttl     = 1
      records = ["${module.redis.private_ip}"]
    },
    {
      name    = "mysql-${var.environment}"
      type    = "A"
      ttl     = 1
      records = ["${module.mysql.private_ip}"]
    },
    {
      name    = "rabbitmq-${var.environment}"
      type    = "A"
      ttl     = 1
      records = ["${module.rabbitmq.private_ip}"]
    },
  ]
}

# output "mongodb_info" {
#   value = module.mongodb
# }