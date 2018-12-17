resource "aws_rds_cluster" "aurora" {
  cluster_identifier = "${var.cluster_identifier}"
  database_name = "${var.db_name}"
  master_username = "${var.root_name}"
  master_password = "${var.root_pass}"
  skip_final_snapshot = true
  engine_mode = "serverless"
  db_subnet_group_name = "${var.subnets}"
  vpc_security_group_ids = ["${var.sg_db}"]
  scaling_configuration {
      auto_pause = true
      max_capacity = "${var.max_capacity}"
      min_capacity = "${var.min_capacity}"
      seconds_until_auto_pause = 300
  }
}
