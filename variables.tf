variable "oss_bucket_config" {
  type = object({
    bucket_name = string
  })
  description = "Configuration for OSS bucket. The bucket_name must be globally unique."
  default = {
    bucket_name = null
  }
}

variable "cdn_domain_config" {
  type = object({
    domain_name = string
    cdn_type    = string
    scope       = string
  })
  description = "Configuration for CDN domain. domain_name is the accelerated domain name, cdn_type can be 'web', 'download', or 'video', scope can be 'domestic', 'overseas', or 'global'."
  default = {
    domain_name = null
    cdn_type    = "web"
    scope       = "domestic"
  }
}

variable "cdn_source_config" {
  type = object({
    type     = string
    priority = number
    port     = number
    weight   = number
  })
  description = "Configuration for CDN source. type can be 'oss', 'ipaddr', or 'domain'."
  default = {
    type     = "oss"
    priority = 20
    port     = 80
    weight   = 10
  }
}

variable "filetype_ttl_config" {
  type = object({
    function_name = string
    function_args = list(object({
      arg_name  = string
      arg_value = string
    }))
  })
  description = "Configuration for CDN file type based TTL settings."
  default = {
    function_name = "filetype_based_ttl_set"
    function_args = [
      {
        arg_name  = "file_type"
        arg_value = "jpg,png,jpeg"
      },
      {
        arg_name  = "weight"
        arg_value = "99"
      },
      {
        arg_name  = "ttl"
        arg_value = "7776000"
      }
    ]
  }
}

variable "oss_key_config" {
  type = object({
    function_name = string
    function_args = list(object({
      arg_name  = string
      arg_value = string
    }))
  })
  description = "Configuration for CDN OSS private key settings."
  default = {
    function_name = "l2_oss_key"
    function_args = [
      {
        arg_name  = "private_oss_auth"
        arg_value = "on"
      },
      {
        arg_name  = "perm_private_oss_tbl"
        arg_value = ""
      }
    ]
  }
}

variable "image_transform_config" {
  type = object({
    function_name = string
    function_args = list(object({
      arg_name  = string
      arg_value = string
    }))
  })
  description = "Configuration for CDN image transformation settings."
  default = {
    function_name = "image_transform"
    function_args = [
      {
        arg_name  = "filetype"
        arg_value = "jpeg"
      },
      {
        arg_name  = "webp"
        arg_value = "off"
      },
      {
        arg_name  = "orient"
        arg_value = "off"
      },
      {
        arg_name  = "slim"
        arg_value = "90"
      },
      {
        arg_name  = "enable"
        arg_value = "on"
      }
    ]
  }
}

variable "dns_record_config" {
  type = object({
    domain_name = string
    host_record = string
    type        = string
  })
  description = "Configuration for DNS record. domain_name is the registered domain, host_record is the subdomain prefix, type is the record type (typically 'CNAME')."
  default = {
    domain_name = null
    host_record = null
    type        = "CNAME"
  }
}

variable "ram_role_config" {
  type = object({
    role_name   = string
    description = string
  })
  description = "Configuration for RAM role used by CDN to access OSS."
  default = {
    role_name   = "AliyunCDNAccessingPrivateOSSRole"
    description = "Role for CDN to access private OSS bucket"
  }
}

variable "create_ram_role" {
  type        = bool
  description = "Whether to create RAM role for CDN to access OSS. Set to false if using existing role."
  default     = true
}

variable "create_ram_policy" {
  type        = bool
  description = "Whether to create RAM policy that grants CDN read-only access to OSS bucket. Set to false if using existing policy."
  default     = true
}

variable "create_dns_record" {
  type        = bool
  description = "Whether to create DNS record for domain resolution. Set to false if managing DNS externally."
  default     = true
}

variable "ram_policy_config" {
  type = object({
    policy_name = string
    description = string
  })
  description = "Configuration for RAM policy that grants CDN read-only access to OSS bucket."
  default = {
    policy_name = "AliyunCDNAccessingPrivateOSSRolePolicy"
    description = "Policy for CDN to access specific private OSS bucket with read-only permissions"
  }
}