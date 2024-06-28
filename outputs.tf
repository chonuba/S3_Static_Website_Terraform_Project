output "s3_bucket_domain_name" {
  value = aws_s3_bucket.web_bucket.bucket_domain_name
}

output "cf_distribution_id" {
  value = aws_cloudfront_distribution.cf_cdn.id
}

output "cf_distro_domain" {
  value = aws_cloudfront_distribution.cf_cdn.domain_name
}

output "nameservers" {
  value = aws_route53_zone.my_zone.name_servers
}