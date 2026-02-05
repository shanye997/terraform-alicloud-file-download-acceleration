# Create OSS bucket for file storage
resource "alicloud_oss_bucket" "oss_bucket" {
  bucket = var.oss_bucket_config.bucket_name
}

# Create CDN domain for acceleration
resource "alicloud_cdn_domain_new" "domain" {
  domain_name = var.cdn_domain_config.domain_name
  cdn_type    = var.cdn_domain_config.cdn_type
  scope       = var.cdn_domain_config.scope

  sources {
    content  = "${alicloud_oss_bucket.oss_bucket.id}.${alicloud_oss_bucket.oss_bucket.extranet_endpoint}"
    type     = var.cdn_source_config.type
    priority = var.cdn_source_config.priority
    port     = var.cdn_source_config.port
    weight   = var.cdn_source_config.weight
  }
}

# Configure CDN domain settings for file type based TTL
resource "alicloud_cdn_domain_config" "filetype_ttl_config" {
  domain_name   = alicloud_cdn_domain_new.domain.domain_name
  function_name = var.filetype_ttl_config.function_name

  dynamic "function_args" {
    for_each = var.filetype_ttl_config.function_args
    content {
      arg_name  = function_args.value.arg_name
      arg_value = function_args.value.arg_value
    }
  }
}

# Configure CDN domain settings for OSS private key
resource "alicloud_cdn_domain_config" "oss_key_config" {
  domain_name   = alicloud_cdn_domain_new.domain.domain_name
  function_name = var.oss_key_config.function_name

  dynamic "function_args" {
    for_each = var.oss_key_config.function_args
    content {
      arg_name  = function_args.value.arg_name
      arg_value = function_args.value.arg_value
    }
  }
}

# Configure CDN domain settings for image transformation
resource "alicloud_cdn_domain_config" "image_transform_config" {
  domain_name   = alicloud_cdn_domain_new.domain.domain_name
  function_name = var.image_transform_config.function_name

  dynamic "function_args" {
    for_each = var.image_transform_config.function_args
    content {
      arg_name  = function_args.value.arg_name
      arg_value = function_args.value.arg_value
    }
  }
}

# Create DNS record for domain resolution
resource "alicloud_dns_record" "domain_record" {
  count       = var.create_dns_record == true ? 1 : 0
  name        = var.dns_record_config.domain_name
  host_record = var.dns_record_config.host_record
  type        = var.dns_record_config.type
  value       = alicloud_cdn_domain_new.domain.cname
}

# Create RAM role for CDN to access OSS
resource "alicloud_ram_role" "role" {
  count                       = var.create_ram_role == true ? 1 : 0
  role_name                   = local.cdn_oss_access_role.name
  assume_role_policy_document = local.cdn_oss_access_role.document
  description                 = local.cdn_oss_access_role.description
}

# Create RAM policy for CDN to access specific OSS bucket
resource "alicloud_ram_policy" "policy" {
  count           = var.create_ram_policy == true ? 1 : 0
  policy_name     = "${local.cdn_oss_access_role_policy.name}-${alicloud_oss_bucket.oss_bucket.id}"
  policy_document = local.cdn_oss_access_role_policy.document
  description     = local.cdn_oss_access_role_policy.description
}

# Attach policy to role
resource "alicloud_ram_role_policy_attachment" "attach" {
  count       = var.create_ram_role == true && var.create_ram_policy == true ? 1 : 0
  role_name   = local.cdn_oss_access_role.name
  policy_name = alicloud_ram_policy.policy[0].policy_name
  policy_type = "Custom"

  depends_on = [alicloud_ram_role.role, alicloud_ram_policy.policy]
}

# Local values for RAM role and policy configuration
locals {
  cdn_oss_access_role = {
    name        = var.ram_role_config.role_name
    description = var.ram_role_config.description
    document = jsonencode({
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = [
              "cdn.aliyuncs.com"
            ]
          }
        }
      ]
      Version = "1"
    })
  }

  cdn_oss_access_role_policy = {
    name        = var.ram_policy_config.policy_name
    description = var.ram_policy_config.description
    document = jsonencode({
      Version = "1"
      Statement = [
        {
          Action = [
            "oss:List*",
            "oss:Get*"
          ]
          Resource = [
            "acs:oss:*:*:${alicloud_oss_bucket.oss_bucket.id}",
            "acs:oss:*:*:${alicloud_oss_bucket.oss_bucket.id}/*"
          ]
          Effect = "Allow"
        }
      ]
    })
  }
}