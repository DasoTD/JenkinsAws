module "vpc" {
    source               = "./modules/vpc"
    vpc_cidr             = var.vpc_cidr
    vpc_name             = var.vpc_name
    cidr_public_subnet   = var.cidr_public_subnet
    availability_zone = var.availability_zone
    cidr_private_subnet  = var.cidr_private_subnet
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ec2_ami_id
  instance_type             = "t2.medium"
  tag_name                  = "capjen"
  public_key                = var.public_key
  subnet_id                 = tolist(module.vpc.capstoneWithJenkins_public_subnets)[0]
  enable_public_ip_address  = true
  security_groups = [module.sg.aws_security_group_id]
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.capstoneWithJenkins_vpc_id
}

/*module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "tteerraaeks"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true



  vpc_id     = module.vpc.capstoneWithJenkins_vpc_id
  subnet_ids = module.vpc.capstoneWithJenkins_private_subnets

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    node1 = {
      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 2
    }


    node2 = {
      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }

  enable_cluster_creator_admin_permissions = true


}*/