# Creating Application Load abalancer
#--------------------------------------------------------------------
resource "aws_lb" "app_alb" {
  name               = "${local.name}-${var.tags.Component}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
  subnets            = split("," , data.aws_ssm_parameter.private_subnet_ids.value) # ALB's are required atleast two subnets, Since this alb is internal we are using private subnets

#   enable_deletion_protection = true

  tags = merge(var.common_tags, var.tags)
}

# Creating "http" listener Application Load abalancer 
#--------------------------------------------------------------------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn 
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, This response is from Application load balancer"
      status_code  = "200"
    }
  }
}

# Create Route53 record for Application Load abalancer 
#--------------------------------------------------------------------
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = "devopsprocloud.in"

  records = [
    {
      name    = "*.app-${var.environment}"
      type    = "A"
      alias   = {
        name    = aws_lb.app_alb.dns_name
        zone_id = aws_lb.app_alb.zone_id
      }
    },
  ]

}