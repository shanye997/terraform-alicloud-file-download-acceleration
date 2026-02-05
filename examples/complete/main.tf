# Generate a random suffix for unique resource names
resource "random_integer" "default" {
  min = 100000
  max = 999999
}

# Configure the Alicloud Provider
provider "alicloud" {
  region = var.region
}

# Call the module
module "fdaaco" {
  source = "../../"

  # OSS bucket configuration
  oss_bucket_config = {
    bucket_name = "${var.bucket_name_prefix}-${random_integer.default.result}"
  }

  # CDN domain configuration
  cdn_domain_config = {
    domain_name = "mycdndomain-${random_integer.default.result}.alicloud-provider.cn"
    cdn_type    = var.cdn_type
    scope       = var.scope
  }

  # CDN source configuration
  cdn_source_config = {
    type     = "oss"
    priority = 20
    port     = 80
    weight   = 10
  }

  create_dns_record = false

  # RAM role and policy creation configuration
  create_ram_role   = var.create_ram_role
  create_ram_policy = var.create_ram_policy

  # Use default configurations for CDN domain configs and RAM settings
}