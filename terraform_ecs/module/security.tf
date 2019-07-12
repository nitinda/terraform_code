# ECS Instance Security group

resource "aws_security_group" "demo-efs-sg" {
    name = "terraform-demo-ecs-efs-sg"
    description = "Test public access security group"
    vpc_id = "${var.vpc_name}"

    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = ["${aws_security_group.test_public_sg.id}"]
    }
}


resource "aws_security_group" "test_public_sg" {
    name = "terraform-demo-ecs-ec2-sg"
    description = "Test public access security group"
    vpc_id = "${var.vpc_name}"
    
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [
           "179.0.0.0/16",
           "10.169.204.0/23"
        ]
    }

    ingress {
        from_port = 50000
        to_port = 50000
        protocol = "tcp"
        cidr_blocks = [
           "179.0.0.0/16",
           "10.169.204.0/23"
        ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [
           "179.0.0.0/16",
           "10.169.204.0/23"
        ]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [
            "179.0.0.0/16",
            "10.169.204.0/23"
        ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "10.33.0.0/16",
            "62.254.158.10/32",
            "179.0.0.0/16",
            "10.169.204.0/23"
        ]
    }

    egress {
        # allow all traffic to private SN
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}


resource "aws_security_group" "test_public_alb_sg" {
    name = "terraform-demo-ecs-alb-sg"
    description = "Test public access security group"
    vpc_id = "${var.vpc_name}"
    
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    
    # egress {
    #     # allow all traffic to private SN
    #     from_port = "80"
    #     to_port = "80"
    #     protocol = "tcp"
    #     security_groups = ["${aws_security_group.test_public_sg.id}"]
    # }
    
    egress {
        # allow all traffic to private SN
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}