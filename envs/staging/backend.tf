terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket       = "gitops-platform-tfstate-885740665747" # the bucket you just created
    key          = "staging/terraform.tfstate"            # path of this env's state file inside the bucket
    region       = "us-east-1"                            # region of the bucket (match yours)
    encrypt      = true                                   # encrypt the state object
    use_lockfile = true                                   # S3-native locking, no DynamoDB
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region # same region
}
