terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      Managed_By = "Terraform"
    }
  }
}

module "vpc" {
  source = "./module/vpc-config"
}

# output "sg" {
#   value = module.vpc.vm1_sg_id
# }

module "ec2" {
  source        = "./module/ec2"
  subnet_id     = module.vpc.private_subnet_id
  vpc_sg_groups = module.vpc.vm1_sg_id
}

module "asg" {
  source           = "./module/asg"
  environment_name = "dev"
  vpc_security_group_idsx = module.vpc.vm1_sg_id
}

module "alb" {
  source                  = "./module/alb"
  environment_name        = "dev"
  vpc_security_group_idsx = module.vpc.vm1_sg_id
  public_subnet_idsx      = module.vpc.public_subnet_id
}

# RETRIVING INFORMATION OF DEFAULT VPC AND SUBNETS
# data "aws_vpc" "default" {
#   default = true
# }

# data "aws_subnets" "default" {
#   filter {
#     name   = "default-for-az"
#     values = ["true"]
#   }
# }
