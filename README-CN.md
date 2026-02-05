# 阿里云文件下载加速及成本优化 Terraform 模块

================================================ 

# terraform-alicloud-file-download-acceleration

[English](https://github.com/terraform-alicloud-modules/terraform-alicloud-file-download-acceleration/blob/master/README.md) | 简体中文

在阿里云上创建完整的文件下载加速和成本优化解决方案的 Terraform 模块。此模块实现了[文件下载加速及成本优化](https://www.aliyun.com/solution/tech-solution/fdaaco)解决方案，涉及内容分发网络（CDN）、云解析（DNS）、对象存储服务（OSS）和访问控制（RAM）资源的部署。

## 使用方法

此模块创建了一个综合的文件加速解决方案，结合了 OSS 存储、CDN 全球内容加速、DNS 域名解析和适当的 RAM 权限以实现安全访问。

```terraform
module "file_acceleration" {
  source = "alibabacloud-automation/file-download-acceleration/alicloud"

  # OSS 存储桶配置
  oss_bucket_config = {
    bucket_name = "my-files-bucket-12345"
  }

  # CDN 域名配置
  cdn_domain_config = {
    domain_name = "cdn.example.com"
    cdn_type    = "web"
    scope       = "domestic"
  }

  # DNS 记录配置
  dns_record_config = {
    domain_name = "example.com"
    host_record = "cdn"
    type        = "CNAME"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-file-download-acceleration/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)