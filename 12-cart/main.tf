module "cart" {
  source = "../../terraform-roboshop-app"
  component_sg_id = data.aws_ssm_parameter.cart_sg_id.value
  private_subnet_id = local.private_subnet_id
  iam_instance_profile = "EC2-Role-For-Shell-Script"
  tags = var.tags
  zone_name = var.zone_name
  rule_priority = 30
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  private_subnet_ids = local.private_subnet_ids
  app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
}