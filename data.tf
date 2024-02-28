data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_route53_zone" "main" {
  name         = var.ssl_zone
  private_zone = false
}