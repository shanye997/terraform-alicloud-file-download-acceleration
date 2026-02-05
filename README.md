# Alicloud File Download Acceleration and Cost Optimization Terraform Module

================================================ 

# terraform-alicloud-file-download-acceleration

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-file-download-acceleration/blob/master/README-CN.md)

Terraform module which creates a complete file download acceleration and cost optimization solution on Alibaba Cloud. This module implements the [File Download Acceleration and Cost Optimization](https://www.aliyun.com/solution/tech-solution/fdaaco) solution, involving the deployment of Content Delivery Network (CDN), Alibaba Cloud DNS, Object Storage Service (OSS), and RAM resources.

## Usage

This module creates a comprehensive file acceleration solution that combines OSS for storage, CDN for global content acceleration, DNS for domain resolution, and proper RAM permissions for secure access.

```terraform
module "file_acceleration" {
  source = "alibabacloud-automation/file-download-acceleration/alicloud"

  # OSS bucket configuration
  oss_bucket_config = {
    bucket_name = "my-files-bucket-12345"
  }

  # CDN domain configuration
  cdn_domain_config = {
    domain_name = "cdn.example.com"
    cdn_type    = "web"
    scope       = "domestic"
  }

  # DNS record configuration
  dns_record_config = {
    domain_name = "example.com"
    host_record = "cdn"
    type        = "CNAME"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-file-download-acceleration/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)