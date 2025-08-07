module "vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  # ami = data.aws_ami.rhel-9.id
  name                   = "${local.ec2_name}-vpn"
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.openvpn_sg_id.value]
  subnet_id              = data.aws_subnet.default_vpc_subnet.id
  create_security_group = false
  user_data = file("openvpn.sh")
  tags = merge(
    var.common_tags,
    {
      Component = "vpn"
    },
    {
      Name = "${local.ec2_name}-vpn"
    }
  )
}
