provider "aws" {
  region = "${var.region}"
}
module "vpc" {
  source = "modules/vpc"
}
module "elb" {
  source = "modules/elb"
}
