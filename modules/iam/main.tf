resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = "${aws_iam_role.ecs_instance_role.name}"
}
resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs_instance_role"
  assume_role_policy = "${file("policies/ecs-role.json")}"
}
resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name = "ecs_instance_role_policy"
  role = "${aws_iam_role.ecs_instance_role.id}"
  policy = "${file("policies/ecs-instance-role.json")}"
}
resource "aws_iam_role" "ecs_service_role" {
  name = "ecs_service_role"
  assume_role_policy = "${file("policies/ecs-role.json")}"
}
resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name = "ecs_service_role_policy"
  role = "${aws_iam_role.ecs_service_role.id}"
  policy = "${file("policies/ecs-service-role.json")}"
}

