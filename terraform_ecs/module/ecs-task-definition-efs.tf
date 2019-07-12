resource "aws_ecs_task_definition" "demo-ecs-task-definition-jenkins-efs" {
    family       = "terraform-demo-ecs-task-definition-efs"
    network_mode = "bridge"
    volume {
        name      = "jenkins-efs"
        host_path = "/mnt/efs"
    }

    placement_constraints {
        type       = "memberOf"
        expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
    }
    
    container_definitions = <<DEFINITION
[
    {
        "name": "jenkins",
        "image": "jenkinsci/jenkins:lts",
        "memory": 1024,
        "cpu": 512,
        "resourceRequirements": null,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 8080,
                "hostPort": 8080,
                "protocol": "tcp"
            }
        ],
        "environment": [
            {
                "Name": "JENKINS_HOME",
                "Value": "/mnt/efs/jenkins"
            }
        ],
        "mountPoints": [
            {
                "sourceVolume": "jenkins-efs",
                "containerPath": "/mnt/efs"
            }
        ]
    }
]
DEFINITION
}

resource "aws_ecs_service" "demo-ecs-service-jenkins-efs" {
  name            = "terraform-demo-ecs-service-jenkins-efs"
  iam_role        = "${aws_iam_role.ecs-service-role.name}"
  cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.demo-ecs-task-definition-jenkins-efs.family}:${max("${aws_ecs_task_definition.demo-ecs-task-definition-jenkins-efs.revision}", "${aws_ecs_task_definition.demo-ecs-task-definition-jenkins-efs.revision}")}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs-service-role.arn}"
  depends_on      = ["aws_iam_role.ecs-service-role"]
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds = 300
  scheduling_strategy = "REPLICA"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.ecs-target-group-instance.arn}"
    container_port   = 8080
    container_name   = "jenkins"
  }
  
  placement_constraints {
      type       = "memberOf"
      expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
  }
  
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  deployment_controller {
      type = "ECS"
  }

}