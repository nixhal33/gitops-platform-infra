terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region # value comes from variables.tf
}

# Reads your account ID at runtime 
data "aws_caller_identity" "current" {}

# Computed once, reused everywhere below.
locals {
  account_id  = data.aws_caller_identity.current.account_id
  bucket_name = "${var.project_name}-tfstate-${local.account_id}"
}

resource "aws_s3_bucket" "state" {
  bucket        = local.bucket_name
  force_destroy = false # refuse to delete if state files exist
}

# Keep old versions of the state file for rollback.
resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypt state at rest.
resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Make public exposure impossible.
resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "state_bucket_name" {
  value = aws_s3_bucket.state.id
}

output "aws_account_id" {
  value = local.account_id
}