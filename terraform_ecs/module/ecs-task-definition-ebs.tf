resource "aws_ecs_task_definition" "demo-ecs-task-definition-nginx-ebs" {
    family       = "terraform-demo-ecs-task-definition-ebs"
    # execution_role_arn = "${aws_iam_role.demo-ecs-task-execution-role.arn}"
    network_mode = "bridge"
    volume {
        name      = "nginx-vol"
        docker_volume_configuration {
            scope         = "shared"
            autoprovision = true
            driver        = "cloudstor:aws"
            driver_opts {
                size    = 20
                backing = "relocatable",
                ebstype = "gp2"
            }
        }
    }

    placement_constraints {
        type       = "memberOf"
        expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
    }
    
    container_definitions = <<DEFINITION
[
    {
        "name": "nginx",
        "image": "nginx:latest",
        "memory": 128,
        "cpu": 128,
        "resourceRequirements": null,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80,
                "protocol": "tcp"
            }
        ],
        "environment": null,
        "mountPoints": [
            {
                "sourceVolume": "nginx-vol",
                "containerPath": "/data"
            }
        ]
    }
]
DEFINITION
}



# resource "aws_ecs_service" "demo-ecs-service" {
#   name            = "terraform-demo-ecs-service-nginx-ebs"
#   iam_role        = "${aws_iam_role.ecs-service-role.name}"
#   cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
#   task_definition = "${aws_ecs_task_definition.demo-ecs-task-definition-nginx-ebs.family}:${max("${aws_ecs_task_definition.demo-ecs-task-definition-nginx-ebs.revision}", "${aws_ecs_task_definition.demo-ecs-task-definition-nginx-ebs.revision}")}"
#   desired_count   = 1
#   deployment_maximum_percent = 200
#   deployment_minimum_healthy_percent = 100
#   health_check_grace_period_seconds = 0
#   scheduling_strategy = "REPLICA"

#   load_balancer {
#     target_group_arn = "${aws_alb_target_group.ecs-target-group-instance.arn}"
#     container_port   = 80
#     container_name   = "nginx"
#   }
  
#   placement_constraints {
#       type       = "memberOf"
#       expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
#   }
  
#   ordered_placement_strategy {
#     type  = "binpack"
#     field = "memory"
#   }

#   deployment_controller {
#       type = "ECS"
#   }
# }