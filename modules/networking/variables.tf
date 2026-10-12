variable "project_name" {
  description = "Prefix used in resource names"
  type        = string                 # e.g. "gitops-platform"
}

variable "environment" {
  description = "Environment name, used in names and tags"
  type        = string                 # "staging" or "prod"
}

variable "vpc_cidr" {
  description = "IP range of the VPC"
  type        = string                 # e.g. "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones to spread subnets across"
  type        = list(string)           # e.g. ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  description = "One CIDR per public subnet"
  type        = list(string)           # e.g. ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "One CIDR per private subnet"
  type        = list(string)           # e.g. ["10.0.11.0/24", "10.0.12.0/24"]
}