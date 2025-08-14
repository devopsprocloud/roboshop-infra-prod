module "openvpn_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "openvpn"
  sg_description = "Securiy Group for OpenVPN"
  vpc_id = data.aws_vpc.default_vpc.id
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "mongodb_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "mongodb"
  sg_description = "Securiy Group for MongoDB"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "redis_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "redis"
  sg_description = "Securiy Group for Redis"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "mysql_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "mysql"
  sg_description = "Securiy Group for MySQL"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "rabbitmq_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "rabbitmq"
  sg_description = "Securiy Group for RabbitMQ"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "catalogue_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "catalogue"
  sg_description = "Securiy Group for Catalogue"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "user_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "user"
  sg_description = "Securiy Group for User"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "cart_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "cart"
  sg_description = "Securiy Group for Cart"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "shipping_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "shipping"
  sg_description = "Securiy Group for Shipping"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "payment_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "payment"
  sg_description = "Securiy Group for Payment"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "web_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "web"
  sg_description = "Securiy Group for Web"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "app_alb_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "app-alb"
  sg_description = "Securiy Group for APP ALB"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

module "web_alb_sg" {
  source = "git::https://github.com/devopsprocloud/terraform-sg-module.git?ref=main"
  sg_name = "web-alb"
  sg_description = "Securiy Group for WEB ALB"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment
}

# Accept all connections in OPENVPN
#----------------------------------------------------------------------------
resource "aws_security_group_rule" "openvpn_home" {
  security_group_id = module.openvpn_sg.sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"  
  cidr_blocks       = ["0.0.0.0/0"]
}


# MONGODB Security Rules
#-----------------------------------------------------------------
resource "aws_security_group_rule" "mongodb_openvpn" {
  security_group_id = module.mongodb_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  security_group_id = module.mongodb_sg.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"  
  source_security_group_id = module.catalogue_sg.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  security_group_id = module.mongodb_sg.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"  
  source_security_group_id = module.user_sg.sg_id
}


# REDIS Security Rules
#---------------------------------------------------------------------------
resource "aws_security_group_rule" "redis_openvpn" {
  security_group_id = module.redis_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  security_group_id = module.redis_sg.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"  
  source_security_group_id = module.user_sg.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  security_group_id = module.redis_sg.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"  
  source_security_group_id = module.cart_sg.sg_id
}

# MYSQL Security Group Rules
#------------------------------------------------------------------

resource "aws_security_group_rule" "mysql_openvpn" {
  security_group_id = module.mysql_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  security_group_id = module.mysql_sg.sg_id
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"  
  source_security_group_id = module.shipping_sg.sg_id
}

# RABBITMQ Security Group Rules
#-------------------------------------------------------------
resource "aws_security_group_rule" "rabbitmq_openvpn" {
  security_group_id = module.rabbitmq_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  security_group_id = module.rabbitmq_sg.sg_id
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"  
  source_security_group_id = module.payment_sg.sg_id
}

#===================================================================


resource "aws_security_group_rule" "catalogue_openvpn" {
  security_group_id = module.catalogue_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "user_openvpn" {
  security_group_id = module.user_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}


resource "aws_security_group_rule" "cart_openvpn" {
  security_group_id = module.cart_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}


# resource "aws_security_group_rule" "cart_shipping" {
#   security_group_id = module.cart_sg.sg_id
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"  
#   source_security_group_id = module.shipping_sg.sg_id
# }

# resource "aws_security_group_rule" "cart_payment" {
#   security_group_id = module.cart_sg.sg_id
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"  
#   source_security_group_id = module.payment_sg.sg_id
# }

resource "aws_security_group_rule" "shipping_openvpn" {
  security_group_id = module.shipping_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}


resource "aws_security_group_rule" "payment_openvpn" {
  security_group_id = module.payment_sg.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

#------------------------------------------------------------------
# APP ALB & Components Security Group Rules
#------------------------------------------------------------------
resource "aws_security_group_rule" "app_alb_openvpn" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_web" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.web_sg.sg_id
}

resource "aws_security_group_rule" "web_alb_internet" {
  security_group_id = module.web_alb_sg.sg_id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"  
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "app_alb_catalogue" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "catalogue_app_alb" {
  security_group_id = module.catalogue_sg.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"  
  source_security_group_id = module.app_alb_sg.sg_id
}


resource "aws_security_group_rule" "app_alb_user" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.user_sg.sg_id
}

resource "aws_security_group_rule" "user_app_alb" {
  security_group_id = module.user_sg.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"  
  source_security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_cart" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.cart_sg.sg_id
}


resource "aws_security_group_rule" "cart_app_alb" {
  security_group_id = module.cart_sg.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"  
  source_security_group_id = module.app_alb_sg.sg_id
}


resource "aws_security_group_rule" "app_alb_shipping" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.shipping_sg.sg_id
}

resource "aws_security_group_rule" "shipping_app_alb" {
  security_group_id = module.shipping_sg.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"  
  source_security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "app_alb_payment" {
  security_group_id = module.app_alb_sg.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"  
  source_security_group_id = module.payment_sg.sg_id
}

resource "aws_security_group_rule" "payment_app_alb" {
  security_group_id = module.payment_sg.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"  
  source_security_group_id = module.app_alb_sg.sg_id
}


#============================================================
# WEB Security Group Rules
#============================================================

resource "aws_security_group_rule" "web_vpn" {
  security_group_id = module.web_sg.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.openvpn_sg.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  security_group_id = module.web_sg.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}