output "oss_bucket_id" {
  description = "The ID of the OSS bucket"
  value       = alicloud_oss_bucket.oss_bucket.id
}

output "oss_bucket_extranet_endpoint" {
  description = "The extranet endpoint of the OSS bucket"
  value       = alicloud_oss_bucket.oss_bucket.extranet_endpoint
}

output "oss_bucket_intranet_endpoint" {
  description = "The intranet endpoint of the OSS bucket"
  value       = alicloud_oss_bucket.oss_bucket.intranet_endpoint
}

output "cdn_domain_name" {
  description = "The accelerated domain name"
  value       = alicloud_cdn_domain_new.domain.domain_name
}

output "cdn_cname" {
  description = "The CNAME domain name corresponding to the accelerated domain"
  value       = alicloud_cdn_domain_new.domain.cname
}

output "origin_server" {
  description = "The origin server address"
  value       = "${alicloud_oss_bucket.oss_bucket.id}.${alicloud_oss_bucket.oss_bucket.extranet_endpoint}"
}

output "dns_record_id" {
  description = "The ID of the DNS record"
  value       = alicloud_dns_record.domain_record[*].id
}

output "ram_role_arn" {
  description = "The ARN of the RAM role for CDN to access OSS"
  value       = var.create_ram_role ? alicloud_ram_role.role[0].arn : null
}

output "ram_policy_name" {
  description = "The name of the RAM policy for CDN to access OSS"
  value       = var.create_ram_policy ? alicloud_ram_policy.policy[0].policy_name : null
}

output "ram_role_policy_attachment_id" {
  description = "The ID of the RAM role policy attachment"
  value       = var.create_ram_role && var.create_ram_policy ? alicloud_ram_role_policy_attachment.attach[0].id : null
}