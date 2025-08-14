
resource "aws_ssm_parameter" "openvpn_sg_prod_id" {
  name  = "/${var.project_name}/${var.environment}/openvpn_sg_prod_id"
  type  = "String"
  value = module.openvpn_sg_prod.sg_id
}

resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mongodb_sg_id"
  type  = "String"
  value = module.mongodb_sg.sg_id
}

resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${var.project_name}/${var.environment}/redis_sg_id"
  type  = "String"
  value = module.redis_sg.sg_id
}

resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql_sg.sg_id
}

resource "aws_ssm_parameter" "rabbitmq_sg_id" {
  name  = "/${var.project_name}/${var.environment}/rabbitmq_sg_id"
  type  = "String"
  value = module.rabbitmq_sg.sg_id
}

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.project_name}/${var.environment}/catalogue_sg_id"
  type  = "String"
  value = module.catalogue_sg.sg_id
}

resource "aws_ssm_parameter" "user_sg_id" {
  name  = "/${var.project_name}/${var.environment}/user_sg_id"
  type  = "String"
  value = module.user_sg.sg_id
}

resource "aws_ssm_parameter" "cart_sg_id" {
  name  = "/${var.project_name}/${var.environment}/cart_sg_id"
  type  = "String"
  value = module.cart_sg.sg_id
}

resource "aws_ssm_parameter" "shipping_sg_id" {
  name  = "/${var.project_name}/${var.environment}/shipping_sg_id"
  type  = "String"
  value = module.shipping_sg.sg_id
}

resource "aws_ssm_parameter" "payment_sg_id" {
  name  = "/${var.project_name}/${var.environment}/payment_sg_id"
  type  = "String"
  value = module.payment_sg.sg_id
}

resource "aws_ssm_parameter" "web_sg_id" {
  name  = "/${var.project_name}/${var.environment}/web_sg_id"
  type  = "String"
  value = module.web_sg.sg_id
}

resource "aws_ssm_parameter" "app_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/app_alb_sg_id"
  type  = "String"
  value = module.app_alb_sg.sg_id
}

resource "aws_ssm_parameter" "web_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/web_alb_sg_id"
  type  = "String"
  value = module.web_alb_sg.sg_id
}