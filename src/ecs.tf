resource "aws_ecs_task_definition" "app" {
  family = "${var.environment_name}_td"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = "512"
  network_mode = "awsvpc"

  container_definitions = <<DEFINITION
[
  {
    "essential": true,
    "image": "${var.app_image}",
    "name": "${var.environment_name}"
  }
]
DEFINITION
}

resource "aws_ecs_service" "app" {
  name            = "${var.environment_name}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = 1
  cluster = "${aws_ecs_cluster.ecs_cluster.id}"
  launch_type = "FARGATE"

  network_configuration {
    subnets = ["${aws_subnet.public_subnets.*.id}"]
    security_groups = ["${aws_security_group.ecs_task.id}"]
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.environment_name}"
}
