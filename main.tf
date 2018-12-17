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
module "alb" {
  source = "./modules/alb"
  subnets = "${module.vpc.subnets}"
  security_groups = "${module.vpc.sg_web}"
  vpc_id = "${module.vpc.vpc_id}"
}

