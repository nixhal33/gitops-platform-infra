# Setting up the variable for the reusability 

# aws region setup
variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

# Short prefix used in resource names.
variable "project_name" {
  description = "Prefix for resource names"
  type        = string
  default     = "gitops-platform"
}