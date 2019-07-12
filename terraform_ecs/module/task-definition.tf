# data "aws_ecs_task_definition" "nginx" {
#   task_definition = "${aws_ecs_task_definition.nginx.family}"
# }

resource "aws_ecs_task_definition" "nginx" {
  family = "terraform-ecs-task-definition"
  network_mode = "host"

  container_definitions = <<DEFINITION
[
    {
        "name": "nginx",
        "image": "nginx:latest",
        "memory": 128,
        "cpu": 128,
        "essential": true,
        "portMappings": [
            {
                "hostPort": 0,
                "containerPort": 80,
                "hostPort": 80,
                "protocol": "tcp"
            }
        ]
    }
]
DEFINITION
}


resource "aws_ecs_service" "test-ecs-service" {
  	name            = "terraform-ecs-service"
  	iam_role        = "${aws_iam_role.ecs-service-role.name}"
  	cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
  	task_definition = "${aws_ecs_task_definition.nginx.family}:${max("${aws_ecs_task_definition.nginx.revision}", "${aws_ecs_task_definition.nginx.revision}")}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${aws_alb_target_group.ecs-target-group.arn}"
    	container_port    = 80
    	container_name    = "nginx"
	}
}