terraform {
  backend "s3" {
    bucket = "sockshop"
    key    = "state-host-machine"
    region = "us-east-1"
  }
}
