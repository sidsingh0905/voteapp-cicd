terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
        }
    }
    
    required_version = ">= 1.0.0"

    backend "s3" {
        bucket         = "voteapp-terraform-state-bucket"
        key            = "terraform.tfstate"
        region         = "ap-south-1"
        dynamodb_table = "voteapp-terraform-state-lock"
        encrypt        = true
      
    }

}

provider "aws" {
    region = "ap-south-1"
}

#to invoke the module, use the following command:
# question-> where are the modules located?
# answer-> As a devops engineer we've a centralized within our org and we source them if abc project 
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  availability_zone = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  cluster_name = var.cluster_name
  
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_groups     = var.node_groups
}