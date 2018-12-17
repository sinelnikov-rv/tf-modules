resource "aws_ecs_cluster" "wordpress" {
  name = "${var.name}"  
}
data "aws_ecs_task_definition" "wordpress" {
  task_definition = "${aws_ecs_task_definition.wordpress.family}"
  depends_on = [ "aws_ecs_task_definition.wordpress" ]
}
data "template_file" "wordpress"{
  template = "${file("task_definitions/wordpress.json")}"
  vars{
    image = "wordpress"
    db_name = "${var.db_name}"
    db_endpoint = "${var.db_endpoint}"
    db_user = "${var.db_user}"
    db_pass = "${var.db_pass}"
  }
}

resource "aws_ecs_task_definition" "wordpress" {
  family = "test"
  container_definitions = "${data.template_file.wordpress.rendered}"
}
resource "aws_ecs_service" "wordpress-service" {
  name = "test"
  cluster = "${aws_ecs_cluster.wordpress.id}"
  task_definition = "${aws_ecs_task_definition.wordpress.family}:${max("${aws_ecs_task_definition.wordpress.revision}", "${data.aws_ecs_task_definition.wordpress.revision}")}"
  iam_role = "${var.ecs_service_role}"
  desired_count = 1
  load_balancer {
    target_group_arn = "${var.target_group}"
    container_port = "80"
    container_name = "wordpress"
  }
}
