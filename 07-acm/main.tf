resource "aws_acm_certificate" "devopsprocloud" {
  domain_name       = "*.devopsprocloud.in"
  validation_method = "DNS"

  tags = merge(var.tags, var.common_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "devopsprocloud" {
  for_each = {
    for dvo in aws_acm_certificate.devopsprocloud.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.devopsprocloud.zone_id
}

resource "aws_acm_certificate_validation" "devopsprocloud" {
  certificate_arn         = aws_acm_certificate.devopsprocloud.arn
  validation_record_fqdns = [for record in aws_route53_record.devopsprocloud : record.fqdn]
}
