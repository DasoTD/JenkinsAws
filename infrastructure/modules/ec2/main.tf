variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "public_key" {}
variable "enable_public_ip_address" {}
variable "tag_name" {}
variable "security_groups" {}


resource "aws_instance" "capstonewithjenkins" {
  ami           = var.ami_id #"ami-0e86e20dae9224db8" # Amazon Linux 2 AMI ID
  instance_type = var.instance_type //"t2.micro"
  subnet_id     = var.subnet_id 
  key_name                    = "aws_ec2_terraform"
  associate_public_ip_address = var.enable_public_ip_address
  security_groups = var.security_groups
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
    Name = var.tag_name
  }
}

resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
  key_name   = "aws_ec2_terraform"
  public_key = var.public_key
}



