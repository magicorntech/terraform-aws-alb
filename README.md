# terraform-aws-alb

Magicorn made Terraform Module for AWS Provider
--
```
module "alb" {
  source      = "magicorntech/alb/aws"
  version     = "0.1.1"
  tenant      = var.tenant
  name        = var.name
  environment = var.environment
  vpc_id      = var.vpc_id
  subnet_ids  = var.pbl_subnet_ids

  # ALB Configuration
  idle_timeout               = 60
  internal                   = false
  drop_invalid_header_fields = true
  enable_deletion_protection = true
  ssl_policy                 = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  route53                    = false
  hosted_zone                = null
  acm_cert_id                = "arn:aws:acm:eu-central-1:533267408375:certificate/4a3d665d-4d86-4128-ae13-d5b0e04782d8" # can be null if route53 true.
}
```