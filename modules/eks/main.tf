variable "source" {}
variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" {}

resource "aws_eks_cluster" "capstoneWithJenkins" {
  name     = var.cluster_name
  role_arn = aws_iam_role.example.arn

  vpc_config {
    subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "sockshopeks"
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


}
