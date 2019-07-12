# # data "aws_ecs_task_definition" "nginx" {
# #   task_definition = "${aws_ecs_task_definition.nginx.family}"
# # }

# resource "aws_ecs_task_definition" "nginx" {
#     family       = "terraform-ecs-task-definition"
#     network_mode = "awsvpc"
#     volume {
#         name      = "nginx-vol"
#         docker_volume_configuration {
#             scope         = "shared"
#             autoprovision = true
#             driver        = "cloudstor:aws"
#             driver_opts {
#                 size    = 10
#                 backing = "relocatable",
#                 ebstype = "gp2"
#             }
#         }
#     }

#     placement_constraints {
#         type       = "memberOf"
#         expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
#     }
    
#     container_definitions = <<DEFINITION
# [
#     {
#         "name": "nginx",
#         "image": "nginx:latest",
#         "memory": 128,
#         "cpu": 128,
#         "resourceRequirements": null,
#         "essential": true,
#         "portMappings": [
#             {
#                 "containerPort": 80,
#                 "hostPort": 80,
#                 "protocol": "tcp"
#             }
#         ],
#         "environment": null,
#         "mountPoints": [
#             {
#                 "sourceVolume": "nginx-vol",
#                 "containerPath": "/data"
#             }
#         ]
#     }
# ]
# DEFINITION
# }



# # resource "aws_ecs_service" "test-ecs-service" {
# #   name            = "terraform-ecs-service"
# #   iam_role        = "${aws_iam_role.ecs-service-role.name}"
# #   cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
# #   task_definition = "${aws_ecs_task_definition.nginx.family}:${max("${aws_ecs_task_definition.nginx.revision}", "${aws_ecs_task_definition.nginx.revision}")}"
# #   desired_count   = 1

# #   load_balancer {
# #     target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
# #     container_port   = 80
# #     container_name   = "nginx"
# #   }
  
# #   placement_constraints {
# #       type       = "memberOf"
# #       expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
# #   }
  
# #   ordered_placement_strategy {
# #     type  = "binpack"
# #     field = "cpu"
# #   }
# # }
