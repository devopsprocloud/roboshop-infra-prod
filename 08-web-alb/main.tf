# Creating Application Load balancer
#--------------------------------------------------------------------
resource "aws_lb" "web_alb" {
  name               = "${local.name}-${var.tags.Component}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.web_alb_sg_id.value]
  subnets            = split("," , data.aws_ssm_parameter.public_subnet_ids.value) # ALB's are required atleast two subnets, Since this alb is internal we are using private subnets

#   enable_deletion_protection = true

  tags = merge(var.common_tags, var.tags)
}

# Creating "https" listener Application Load balancer 
#--------------------------------------------------------------------
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web_alb.arn 
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = data.aws_ssm_parameter.acm_certificate_arn.value
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, This response is from WEB load balancer using HTTPS"
      status_code  = "200"
    }
  }
}

# Create Route53 record for Application Load balancer 
#--------------------------------------------------------------------
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "web-${var.environment}"
      type    = "A"
      alias   = {
        name    = aws_lb.web_alb.dns_name
        zone_id = aws_lb.web_alb.zone_id
      }
    },
  ]

}