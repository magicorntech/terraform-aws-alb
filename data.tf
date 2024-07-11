data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_route53_zone" "main" {
  count        = (var.route53 == true) ? 1 : 0
  name         = var.hosted_zone
  private_zone = false
}