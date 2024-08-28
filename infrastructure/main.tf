# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}

# Create a public subnet within the VPC
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "example-subnet"
  }
}

# Create a security group within the same VPC
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.example.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Create an EC2 instance using the subnet and security group from the same VPC
resource "aws_instance" "web" {
  ami           = "ami-0e86e20dae9224db8" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  //availability_zone = "us-east-1a"
  subnet_id     = aws_subnet.example.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  //key_name      = "public"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y unzip curl
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install
              aws --version
              EOF

  tags = {
    Name = "Terraform-Example"
  }
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "terraeks"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true



  vpc_id     = aws_vpc.example.id
  subnet_ids = aws_subnet.example.id 

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
