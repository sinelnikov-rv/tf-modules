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
  root_name = "wordpress"
  root_pass = "w0rdpr3ss"
  sg_db = "${module.vpc.sg_db}"
  subnets = "${module.vpc.db_subnets}"
}
module "alb" {
  source = "./modules/alb"
  subnets = "${module.vpc.subnets}"
  security_groups = "${module.vpc.sg_web}"
  vpc_id = "${module.vpc.vpc_id}"
}
module "iam" {
  source = "./modules/iam"
}
module "asg" {
  source = "./modules/asg"
  ecs_instance_profile = "${module.iam.ecs_instance_profile}"
  security_groups = "${module.vpc.sg_web}"
  subnets = "${module.vpc.subnets}"
}
module "ecs" {
  source = "modules/ecs"
  name = "test"
  db_name = "wordpress"
  db_user = "wordpress"
  db_pass = "w0rdpr3ss"
  db_endpoint = "${module.db.endpoint}"
  ecs_service_role = "${module.iam.ecs_service_role}"
  target_group = "${module.alb.target_group}"
}




