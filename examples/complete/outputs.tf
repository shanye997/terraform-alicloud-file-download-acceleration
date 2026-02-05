output "oss_bucket_id" {
  description = "The ID of the OSS bucket"
  value       = module.fdaaco.oss_bucket_id
}

output "oss_bucket_extranet_endpoint" {
  description = "The extranet endpoint of the OSS bucket"
  value       = module.fdaaco.oss_bucket_extranet_endpoint
}

output "cdn_domain_name" {
  description = "The accelerated domain name"
  value       = module.fdaaco.cdn_domain_name
}

output "cdn_cname" {
  description = "The CNAME domain name corresponding to the accelerated domain"
  value       = module.fdaaco.cdn_cname
}

output "origin_server" {
  description = "The origin server address"
  value       = module.fdaaco.origin_server
}

output "dns_record_id" {
  description = "The ID of the DNS record"
  value       = module.fdaaco.dns_record_id
}

output "ram_policy_name" {
  description = "The name of the RAM policy for CDN to access OSS"
  value       = module.fdaaco.ram_policy_name
}