resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "terraform-demo-ecs-autoscaling-group"
    max_size                    = "3"
    min_size                    = "1"
    desired_capacity            = "1"
    vpc_zone_identifier         = "${var.subnets}"
    launch_configuration        = "${aws_launch_configuration.ecs-launch-configuration.name}"
    health_check_type           = "ELB"
    health_check_grace_period   = 0
    default_cooldown            = 0

    lifecycle {
        create_before_destroy = true
    }
    # target_group_arns = ["${aws_alb_target_group.ecs-target-group.arn}"]

    tags = [
        {
            key                 = "Name"
            value               = "terraform-demo-ecs-ec2-instanace"
            propagate_at_launch = true
        }
    ]
}