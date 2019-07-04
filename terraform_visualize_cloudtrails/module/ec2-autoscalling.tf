resource "aws_autoscaling_group" "demo-autoscaling-group-ec2" {
  # availability_zones        = ["${data.aws_availability_zones.demo-available.names}"]
  name_prefix               = "terraform-demo-asg-ec2"
  max_size                  = 4
  min_size                  = 1
  desired_capacity          = 3
  health_check_grace_period = 0
  force_delete              = false
  vpc_zone_identifier       = ["${aws_subnet.demo-terraform-subnet-private.*.id}"]
  default_cooldown          = 1
  
  tag {
    key                 = "Name"
    value               = "terraform-demo-ec2-eks-worker-node"
    propagate_at_launch = true
  }

  launch_template {
    id      = "${aws_launch_template.demo-launch-template-ec2.id}"
    version = "$$Latest"
  }
}