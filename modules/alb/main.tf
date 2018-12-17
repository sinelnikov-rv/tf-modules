resource "aws_alb" "alb" {
  name = "test-alb"
  subnets = ["${var.subnets}"]
  security_groups = ["${var.security_groups}"]
  idle_timeout = 400
}
resource "aws_alb_target_group" "test" {
    name = "test"
    port = 80
    protocol = "HTTP"
    vpc_id = "${var.vpc_id}"
    deregistration_delay = 180
    health_check {
        interval = 60
        path = "/"
        port = "80"
        healthy_threshold = "3"
        unhealthy_threshold = "5"
        timeout = "5"
        protocol = "HTTP"
    }
}
resource "aws_alb_listener" "wordpress" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = "80"
  protocol = "HTTP"
  default_action {
      target_group_arn = "${aws_alb_target_group.test.arn}"
      type = "forward"
  }
}
