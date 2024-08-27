variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "availability_zone" {}
variable "cidr_private_subnet" {}

output "capstoneWithJenkins_vpc_id" {
  value = aws_vpc.capstoneWithJenkins.id
}

output "capstoneWithJenkins_public_subnets" {
  value = aws_subnet.capstoneWithJenkins_public_subnets.*.id
}

output "capstoneWithJenkins_private_subnets" {
  value = aws_subnet.capstoneWithJenkins_private_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.capstoneWithJenkins_public_subnets.*.cidr_block
}

# Setup VPC
resource "aws_vpc" "capstoneWithJenkins" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}


# Setup public subnet
resource "aws_subnet" "capstoneWithJenkins_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.capstoneWithJenkins.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "capstoneWithJenkins-public-subnet-${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "capstoneWithJenkins_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.capstoneWithJenkins.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "capstoneWithJenkins-private-subnet-${count.index + 1}"
  }
}

# Setup Internet Gateway
resource "aws_internet_gateway" "capstoneWithJenkins_public_internet_gateway" {
  vpc_id = aws_vpc.capstoneWithJenkins.id
  tags = {
    Name = "capstoneWithJenkins-1-igw"
  }
}

# Public Route Table
resource "aws_route_table" "capstoneWithJenkins_public_route_table" {
  vpc_id = aws_vpc.capstoneWithJenkins.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.capstoneWithJenkins_public_internet_gateway.id
  }
  tags = {
    Name = "capstoneWithJenkins_public-rt"
  }
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "capstoneWithJenkins_public_rt_subnet_association" {
  count          = length(aws_subnet.capstoneWithJenkins_public_subnets)
  subnet_id      = aws_subnet.capstoneWithJenkins_public_subnets[count.index].id
  route_table_id = aws_route_table.capstoneWithJenkins_public_route_table.id
}

# Private Route Table
resource "aws_route_table" "capstoneWithJenkins_private_subnets" {
  vpc_id = aws_vpc.capstoneWithJenkins.id
  #depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "capstoneWithJenkins-1-private-rt"
  }
}

# Private Route Table and private Subnet Association
resource "aws_route_table_association" "capstoneWithJenkins_private_rt_subnet_association" {
  count          = length(aws_subnet.capstoneWithJenkins_private_subnets)
  subnet_id      = aws_subnet.capstoneWithJenkins_private_subnets[count.index].id
  route_table_id = aws_route_table.capstoneWithJenkins_private_subnets.id
}