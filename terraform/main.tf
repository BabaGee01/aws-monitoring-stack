terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source             = "./modules/vpc"
  aws_region         = var.aws_region
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

module "ec2" {
  source     = "./modules/ec2"
  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.vpc.public_subnet_id
  ami_id     = var.ami_id
  key_name   = var.key_name
  my_ip      = var.my_ip
}

module "cloudwatch" {
  source       = "./modules/cloudwatch"
  instance_id  = module.ec2.instance_id
  alert_email  = var.alert_email
}