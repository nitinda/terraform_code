resource "aws_autoscaling_group" "demo-autoscaling-group-ec2" {
  # availability_zones        = ["${data.aws_availability_zones.demo-available.names}"]
  name_prefix               = "terraform-demo-autoscaling-group-ec2"
  max_size                  = 6
  min_size                  = 1
  desired_capacity          = 4
  health_check_grace_period = 0
  force_delete              = false
  vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]
  default_cooldown          = 1
  target_group_arns = ["${aws_lb_target_group.demo-application-loadbalancer-target-group.arn}"]
  
  tag {
    key                 = "Name"
    value               = "terraform-demo-ec2"
    propagate_at_launch = true
  }

  launch_template {
    id      = "${aws_launch_template.demo-launch-template-ec2.id}"
    version = "$$Latest"
  }
}