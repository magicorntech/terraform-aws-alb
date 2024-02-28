resource "aws_security_group" "main" {
  name        = "${var.tenant}-${var.name}-alb-sg-${var.environment}"
  description = "Managed by Magicorn"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-alb-sg-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Terraform   = "yes"
  }
}