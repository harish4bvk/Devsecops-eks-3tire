provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  cidr_block = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "eks" {
  source = "../../modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets
}

module "rds" {
  source = "../../modules/rds"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}