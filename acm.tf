resource "aws_acm_certificate" "main" {
  count                     = (var.route53 == true) ? 1 : 0
  domain_name               = var.hosted_zone
  subject_alternative_names = ["*.${var.hosted_zone}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-main-certificate-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Terraform   = "yes"
  }
}

##### Create Certificate Validation Records
resource "aws_route53_record" "main" {
  for_each = var.route53 == true ? {
    for dvo in aws_acm_certificate.main[0].domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.main[0].zone_id
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = each.value.zone_id
}

##### Ask ACM to Validate the Certificate
resource "aws_acm_certificate_validation" "main" {
  count                   = (var.route53 == true) ? 1 : 0
  certificate_arn         = aws_acm_certificate.main[0].arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}
