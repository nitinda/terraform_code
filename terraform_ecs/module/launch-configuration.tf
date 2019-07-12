resource "aws_launch_configuration" "ecs-launch-configuration" {
    name_prefix                 = "terraform-demo-ecs-launch-configuration-"
    image_id                    = "ami-075703041f2f591b9"
    instance_type               = "t2.large"
    iam_instance_profile        = "${aws_iam_instance_profile.ecs-instance-profile.id}"

    root_block_device {
      volume_type = "gp2"
      volume_size = 50
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = ["${aws_security_group.test_public_sg.id}"]
    associate_public_ip_address = false
    key_name                    = "shared-services"
    user_data                   = "${data.template_file.asg_userdata.rendered}"
}


data "template_file" "asg_userdata" {
  template = "${file("../module/files/userdata.sh")}"

  vars {
    ECS_CLUSTER_NAME = "${var.ecs-cluster-name}"
    EFS_ID_REGULAR   = "${aws_efs_file_system.demo-efs-ecs.id}"    
  }
}