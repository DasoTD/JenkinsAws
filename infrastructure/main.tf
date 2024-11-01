/*module "vpc" {
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

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "capteraeks"
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
      desired_size = 1
    }

  }

  enable_cluster_creator_admin_permissions = true


}*/

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "sockshopvpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



/*module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "shopeks"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true



  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets 

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


}*/


module "ec2" {
  source = "./modules/ec2"
  instance_type             = "t2.medium"
  tag_name                  = "CAPITOL"
  public_key                = var.public_key
  subnet_id                 = tolist(module.vpc.private_subnets)[0]
  enable_public_ip_address  = true
  security_groups = [module.sg.aws_security_group_id]
  user_data_install_aws = templatefile("./modules/aws/install_aws.sh", {})

}



module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}