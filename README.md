# terraform-aws-alb

Magicorn made Terraform Module for AWS Provider
--
```
module "alb" {
  source         = "magicorntech/alb/aws"
  version        = "0.0.1"
  tenant         = var.tenant
  name           = var.name
  environment    = var.environment
  vpc_id         = var.vpc_id
  pbl_subnet_ids = var.pbl_subnet_ids

  # ALB Configuration
  idle_timeout               = 300
  drop_invalid_header_fields = true
  enable_deletion_protection = true
  ssl_policy                 = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  ssl_zone                   = "subdomain.example.net" # must reside at route53
}
```