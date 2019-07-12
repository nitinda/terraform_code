resource "aws_lb" "demo-application-loadbalancer" {
  name               = "terraform-demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.vpc_security_group_ids}"]
  subnets            = ["${var.public_subnets}"]

  enable_deletion_protection = false
  tags = {
    Environment = "terraform-demo-application-loadbalancer"
  }
}

resource "aws_lb_listener" "demo-application-loadbalancer-listener" {
  load_balancer_arn = "${aws_lb.demo-application-loadbalancer.arn}"
  # port              = "443"
  # protocol          = "HTTPS"
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "${data.aws_acm_certificate.demo-acm-certificate.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.demo-application-loadbalancer-target-group.arn}"
  }
}

resource "aws_lb_target_group" "demo-application-loadbalancer-target-group" {
  name     = "terraform-demo-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  deregistration_delay = 0
}