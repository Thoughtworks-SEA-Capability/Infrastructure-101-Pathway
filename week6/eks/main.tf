# Provider
provider "aws" {
  region = "ap-southeast-1"
}

# Locals
locals {
  cluster_name = <INSERT CLUSTER NAME>
}

# VPC and Subnets

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "${local.cluster_name}-vpc"
  cidr                 = "192.168.0.0/20"
  azs                  = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets      = ["SPLIT", "THE"]
  public_subnets       = ["CIDR RANGE", "ACCORDINGLY"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Tags are required for EKS to recognise these subnets
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = local.cluster_name
  cluster_endpoint_public_access = "true"

  tags = {
    environment = local.cluster_name
  }

  vpc_id  = <VPC ID>
  subnets = <PRIVATE SUBNETS ID>

  worker_groups = [
    {
      autoscaling_enabled  = true
      asg_min_size         = 2
      asg_max_size         = 2
      asg_desired_capacity = 2
      instance_type        = "t3.small"
    }
  ]
}
