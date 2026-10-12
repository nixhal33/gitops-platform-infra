module "networking" {
  source = "../../modules/networking"

  project_name         = "gitops-platform"
  environment          = "staging"
  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"] # your region + a, b
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
}

output "vpc_id" {
  value = module.networking.vpc_id
}