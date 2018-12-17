provider "aws" {
  region = "${var.region}"
}
module "vpc" {
  source = "./modules/vpc"
}
module "db" {
  source = "./modules/db-cluster"
  cluster_identifier = "wordpress"
  db_name = "wordpress"
  root_name = "admin"
  root_pass = "r1BT5hzA"
  sg_db = "${module.vpc.sg_db}"
  subnets = "${module.vpc.db_subnets}"
}
module "elb" {
  source = "./modules/elb"
  subnets = "${module.vpc.subnets}"
  security_groups = "${module.vpc.sg_web}"
  listener = [
    {
      instance_port = "80"
      instance_protocol = "HTTP"
      lb_port = "80"
      lb_protocol = "HTTP"
    }
  ]
}

