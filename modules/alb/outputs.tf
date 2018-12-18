output "target_group" {
  value = "${aws_alb_target_group.test.arn}"
}
output "dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
