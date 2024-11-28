bucket_name = "capstoneWithJenkins"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "capstoneWithJenkins"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone = ["us-east-1a", "us-east-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClLnPVUB5SxIBuaThD8AYLDStbYqUVXUGsFlfJa3ca2I/4dIMo5dRO+zuumtO+y+FwYwLdE+Bz1mQPP0XWVdZw3OMjWIkvD7GGNWgg0rTl6Zle6ZFGo/5zZYBTHtPPTuXBvwcXfIMm7SvgTDUozLK6cPfifk8KLdo5l5JXxYedTYikkchY81Xlrm5JGh6i7E1Sjdq+/I8/P6g1HUsdKm31E1565cU7rcCmajLw24ZFFUm+TXv5iLJ9kcnxkZ8zsj+Pd9f+eR3pFXU5ujzDkAbXkPwT9+2sZNJ3zlE60EuiYBtXIb5guaawuq1C0GpChMwYjUyQ+UgQ6RT9TuhRF+WnvZtEJEkxHb6xBInBs8TvRo7iKEXjmgAVyet0pegcMuxTWboDryNeO5Fl9fz8rHW/doArYajztN+4/CMexiDn41sghw0wei45VOLdk4mTyNrAQpG1djwdg25uS8t5EIQcxoBVa0zSzK8pnQ5Q858ol7G8VdW3UD+hSI305ii8/qM= xybuild@jesse"
ec2_ami_id     = "ami-0e86e20dae9224db8"

//ec2_user_data_install_jenkins = ""

domain_name = "timileyindaso.com"
