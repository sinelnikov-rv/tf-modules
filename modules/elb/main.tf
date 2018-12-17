resource "aws_elb" "elb" {
  subnets  =["${var.subnets}"]
  security_groups = ["${var.security_groups}"]
  listener = ["${var.listener}"]
}
