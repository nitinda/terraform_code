resource "aws_alb" "ecs-load-balancer" {
    name                = "terraform-demo-ecs-load-balancer"
    security_groups     = ["${aws_security_group.test_public_alb_sg.id}"]
    subnets             = "${var.subnet_public}"

    tags {
      Name = "ecs-load-balancer"
    }
}

resource "aws_alb_target_group" "ecs-target-group-instance" {
    name                = "terraform-demo-ecs-tg-instance"
    port                = "8080"
    protocol            = "HTTP"
    vpc_id              = "${var.vpc_name}"

    health_check {
        healthy_threshold   = "2"
        unhealthy_threshold = "2"
        interval            = "5"
        matcher             = "200"
        path                = "/login"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "3"
    }

    deregistration_delay = 5

    tags {
      Name = "terraform-demo-ecs-tg-instance"
    }
}

resource "aws_alb_target_group" "ecs-target-group-ip" {
    name                = "terraform-demo-ecs-tg-ip"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              = "${var.vpc_name}"
    target_type         = "ip"

    health_check {
        healthy_threshold   = "2"
        unhealthy_threshold = "2"
        interval            = "5"
        matcher             = "200"
        path                = "/login"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "3"
    }

    deregistration_delay = 5

    tags {
      Name = "terraform-demo-ecs-tg-ip"
    }
}

resource "aws_alb_listener" "alb-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = "arn:aws:acm:eu-central-1:735276988266:certificate/58f37cab-8bdb-48c3-a2b8-a37780c2f76a"
    depends_on        = ["aws_alb.ecs-load-balancer"]


    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group-instance.arn}"
        type             = "forward"
    }
}