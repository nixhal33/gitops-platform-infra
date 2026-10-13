variable "cloud_provider" {
  description = "Cloud provider for this environment"
  type        = string
  default     = "aws"
}

variable "aws_region" {
  description = "AWS region for this environment"
  type        = string
  default     = "us-east-1"
}

variable "admin_cidr" {
  description = "Your public IP in CIDR form, allowed to reach admin ports"
  type        = string
}
