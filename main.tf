##### Create Load Balancer
resource "aws_alb" "main" {
  name                       = "${var.tenant}-${var.name}-alb-${var.environment}"
  subnets                    = var.pbl_subnet_ids
  security_groups            = [aws_security_group.main.id]
  idle_timeout               = var.idle_timeout
  internal                   = false
  drop_invalid_header_fields = var.drop_invalid_header_fields
  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name        = "${var.tenant}-${var.name}-alb-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Terraform   = "yes"
  }
}

##### Redirect all traffic from HTTP to HTTPS
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##### Forward default action to 404
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.main.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = aws_acm_certificate.main.arn
  
  default_action {
    type           = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}