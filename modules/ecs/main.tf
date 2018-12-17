resource "aws_ecs_cluster" "wordpress" {
  name = "${var.name}"  
}

resource "aws_ecs_service" "wordpress" {
  cluster = "${aws_ecs_cluster.wordpress.id}"
  task_definition = "${aws_ecs_task_definition.wordpress.arn}"
  iam_role = "${var.ecs_service_role}"
 
}
