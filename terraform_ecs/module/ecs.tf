resource "aws_ecs_cluster" "test-ecs-cluster" {
  name = "${var.ecs-cluster-name}"
}




# resource "aws_ecs_task_definition" "demo" {
#   family                = "terraform-ecs-task-definition-ec2"
#   container_definitions = "${file("../module/task-definitions/service.json")}"

#   task_role_arn = "arn:aws:iam::735276988266:role/ECSTaskDefinitionRole"
#   execution_role_arn = "arn:aws:iam::735276988266:role/ecsTaskExecutionRole"

#   requires_compatibilities = ["EC2"]

#   network_mode = "awsvpc"

#   # volume {
#   #   name      = "service-storage"
#   #   host_path = "/ecs/service-storage"
#   # }

#   # placement_constraints {
#   #   type       = "memberOf"
#   #   expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
#   # }
# }





# resource "aws_ecs_service" "demo" {
#   name            = "terraform-ecs-service"
#   cluster         = "${aws_ecs_cluster.demo.id}"
#   task_definition = "${aws_ecs_task_definition.demo.arn}"
#   desired_count   = 1
#   # iam_role        = "arn:aws:iam::735276988266:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
#   launch_type     = "EC2"
#   scheduling_strategy = "DAEMON"

#   # ordered_placement_strategy {
#   #   type  = "binpack"
#   #   field = "cpu"
#   # }

#   # load_balancer {
#   #   target_group_arn = "${aws_lb_target_group.foo.arn}"
#   #   container_name   = "mongo"
#   #   container_port   = 8080
#   # }

#   # placement_constraints {
#   #   type       = "memberOf"
#   #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   # }
#   network_configuration {
#     subnets = ["subnet-2145124a","subnet-d0aa26ad"]
#     security_groups = ["sg-044d3c35347391913"]
#     assign_public_ip = false
#   }
# }