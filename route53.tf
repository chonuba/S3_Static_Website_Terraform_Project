
# Creating hosted zone
resource "aws_route53_zone" "my_zone" {
  name         = "oldyungdev.tech"
}

# AWS Route53 record resource for the "www" subdomain. The record uses an "A" type record and an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "oldyungdev.tech"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cf_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# AWS Route53 record resource for the apex domain (root domain) with an "A" type record. The record uses an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.my_zone.id
  name    = "www.oldyungdev.tech"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cf_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# AWS Route53 record resource for certificate validation with dynamic for_each loop and properties for name, records, type, zone_id, and ttl.
resource "aws_route53_record" "cert_validation" {
  #provider = aws.use_default_region
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = aws_route53_zone.my_zone.zone_id
  ttl             = 60
}