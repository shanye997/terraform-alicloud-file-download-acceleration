variable "region" {
  type        = string
  description = "The Alibaba Cloud region where resources will be created"
  default     = "cn-hangzhou"
}

variable "bucket_name_prefix" {
  type        = string
  description = "The prefix for OSS bucket name. Must be 3-63 characters, start and end with lowercase letter or number, can contain lowercase letters, numbers and hyphens"
  default     = "fdaaco-example"
}


variable "cdn_type" {
  type        = string
  description = "The CDN type for the accelerated domain"
  default     = "web"
}

variable "scope" {
  type        = string
  description = "The acceleration scope. When scope is domestic or global, the domain must be filed"
  default     = "overseas"
}

variable "create_ram_role" {
  type        = bool
  description = "Whether to create RAM role for CDN to access OSS"
  default     = true
}

variable "create_ram_policy" {
  type        = bool
  description = "Whether to create RAM policy that grants CDN read-only access to OSS bucket"
  default     = true
}