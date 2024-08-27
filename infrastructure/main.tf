module "vpc" {
    source               = "./modules/vpc"
    vpc_cidr             = var.vpc_cidr
    vpc_name             = var.vpc_name
    cidr_public_subnet   = var.cidr_public_subnet
    availability_zone = var.availability_zone
    cidr_private_subnet  = var.cidr_private_subnet
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "capstoneWithJenkins"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true



  vpc_id     = module.vpc.capstoneWithJenkins_vpc_id
  subnet_ids = module.vpc.capstoneWithJenkins_private_subnets

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    node1 = {
      instance_types = ["t2.xlarge"]

      min_size     = 1
      max_size     = 2
      desired_size = 2
    }


    node2 = {
      instance_types = ["t2.xlarge"]

      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }

  enable_cluster_creator_admin_permissions = true


}