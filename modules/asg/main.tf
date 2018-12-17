resource "aws_launch_configuration" "ecs" {
  image_id = "${var.ami}"
  instance_type = "${var.type}"
  iam_instance_profile = "${var.ecs_instance_profile}"
  key_name = "${var.key_name}"
  user_data = "${data.template_file.autoscaling_user_data.rendered}"
  security_groups = ["${var.security_groups}"]
  associate_public_ip_address = true
}
resource "aws_autoscaling_group" "ecs" {
  name = "${var.name}"
  max_size = 1
  min_size = 1
  desired_capacity = 1
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  vpc_zone_identifier = ["${var.subnets}"]
}

data "template_file" "autoscaling_user_data" {
    template = "${file("modules/asg/autoscaling_user_data.tpl")}"
    vars {
        ecs_cluster = "test"
    }
}