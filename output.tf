output "alb_arn" {
    value = aws_alb.main.arn
}

output "alb_dns_name" {
    value = aws_alb.main.dns_name
}

output "alb_zone_id" {
    value = aws_alb.main.zone_id
}

output "alb_https" {
    value = aws_alb_listener.https.arn
}

output "hosted_zone" {
    value = data.aws_route53_zone.main.zone_id
}