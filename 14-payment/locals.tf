locals {
  private_subnet_id = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
}