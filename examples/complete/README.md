# Complete Example

This example demonstrates how to use the File Download Acceleration and Cost Optimization (FDAACO) module to create a complete file acceleration solution using Alibaba Cloud CDN, OSS, and DNS services.

## Overview

This example creates:
- An OSS bucket for file storage
- A CDN domain for content acceleration
- DNS record to point your domain to the CDN
- RAM role and policy for CDN to access OSS bucket
- CDN domain configurations for file type TTL, OSS private key, and image transformation

## Usage

To run this example:

1. Copy this example to a new directory
2. Set the required variables in `terraform.tfvars`:

```hcl
domain_name   = "example.com"     # Your registered domain
domain_prefix = "cdn"             # Subdomain prefix
region        = "cn-hangzhou"     # Alibaba Cloud region
```

3. Initialize and apply:

```bash
terraform init
terraform plan
terraform apply
```

## Requirements

- You must have a registered domain name that is filed under your Alibaba Cloud account
- The domain must be properly filed for domestic or global scope acceleration
- Appropriate Alibaba Cloud credentials must be configured

## Resources Created

- `alicloud_oss_bucket`: Object storage bucket for files
- `alicloud_cdn_domain_new`: CDN domain for acceleration
- `alicloud_cdn_domain_config`: Multiple CDN configurations
- `alicloud_dns_record`: DNS CNAME record
- `alicloud_ram_role`: Role for CDN to access OSS
- `alicloud_ram_policy`: Policy for CDN OSS access permissions
- `alicloud_ram_role_policy_attachment`: Attachment of policy to role

## Outputs

After successful deployment, you'll get:
- OSS bucket information
- CDN domain name and CNAME
- DNS record details
- RAM policy information

## Clean Up

To destroy the resources:

```bash
terraform destroy
```

Note: Make sure to backup any important data in the OSS bucket before destroying.