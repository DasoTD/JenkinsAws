bucket_name = "capstoneWithJenkins"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "capstoneWithJenkins"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone = ["us-east-1a", "us-east-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4o3y2eX2RKeIcjtRgQd6D7kHM3EGPbpbYcT7L+igjg1bMIJw7ermOZLQ0ml/8Y+GU/uMGThR0bQqoLjMN2CDcDvIC1aaqc1TqIUT7gYK+z0yDsQHAV7vX+EvOx2nYzvxrx7wS8I9XL7N5RD22YjFR1ZGQQlmos++o0FtAPIghs4lcKo9FqTbSH9D5TYYxfm+qe1mhGRkNoihe4TbRJ3NujgtbuAo559R6W4GcgahcFdLYyIWvcnz6BdkCTUWN06fI5LQxah4+U5H3zxAySH67QxZM3+mk/esTPujd+Z+be9Gdm0cn5MXjGKzHuF7iZtvY2iA+RHJsY56NKTinz3gZw4QRpZjEUPH0uJCx3I2ZQigS9ufbUh1PE4PGLnqAZsnC/fsVaaUhxX33LBMGlApF8ZCqePbzCEcIWLc7G/msR6rmOkoYXtfwyYk9DE2xChB917/HhgHu3Lgd+JPJG7jAz9u8+p38C6aPPgS2vi2UaeZ6xdLMVgN3xavPatVppE8= root@jesse"
ec2_ami_id     = "ami-0e86e20dae9224db8"

//ec2_user_data_install_jenkins = ""

domain_name = "timileyindaso.com"
