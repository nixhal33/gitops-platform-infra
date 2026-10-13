variable "project_name" {
  description = "Prefix used in resource names"
  type        = string                  # e.g. "gitops-platform"
}

variable "environment" {
  description = "Environment name, used in names and tags"
  type        = string                  # "staging" or "prod"
}

variable "vpc_id" {
  description = "VPC where the security group is created"
  type        = string                  # comes from module.networking.vpc_id
}

variable "admin_cidr" {
  description = "Your public IP in CIDR form, allowed to reach admin ports"
  type        = string                  # e.g. "203.0.113.25/32" (find yours with: curl ifconfig.me)
}