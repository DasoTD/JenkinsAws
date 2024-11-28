variable "instance_type" {}
variable "subnet_id" {}
variable "public_key" {}
variable "enable_public_ip_address" {}
variable "tag_name" {}
variable "security_groups" {}

variable "user_data_install_aws" {}


resource "aws_instance" "capstonewithjenkins" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = var.instance_type
  subnet_id     = var.subnet_id 
  key_name                    = aws_key_pair.jenkins_ec2_key_pair.key_name
  associate_public_ip_address = var.enable_public_ip_address
  vpc_security_group_ids = var.security_groups
  user_data = var.user_data_install_aws
  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }

    tags = {
    Name = var.tag_name
  }
}

resource "aws_key_pair" "jenkins_ec2_key_pair" {
  key_name   = "aws_ec2_terraform"
  public_key = var.public_key
}



