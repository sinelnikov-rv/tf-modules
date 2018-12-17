output "vpc_id" {
    value = "${aws_vpc.vpc.id}"
}
output "subnets" {
    value = ["${aws_subnet.public.*.id}"]
}
output "sg_web" {
  value = ["${aws_security_group.web.id}"]
}
output "sg_db" {
  value = ["${aws_security_group.db.id}"]
}
output "db_subnets" {
  value = "${aws_db_subnet_group.db_subnets.id}"
}

