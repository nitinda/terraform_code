resource "aws_efs_file_system" "demo-efs-ecs" {
  creation_token = "terraform-demo-efs-ecs"
  tags = {
    Name = "terraform-demo-efs-ecs"
  }
}

resource "aws_efs_mount_target" "demo-efs-mount-targets-ecs" {
  count          = "${length(var.subnets)}"
  file_system_id = "${aws_efs_file_system.demo-efs-ecs.id}"
  subnet_id      = "${var.subnets[count.index]}"
  security_groups = ["${aws_security_group.demo-efs-sg.id}"]
}