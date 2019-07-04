

# data "template_file" "asg_userdata" {
#   template = "${file("../module/files/userdata.sh")}"
# }


resource "aws_launch_template" "demo-launch-template-ec2" {
  name_prefix   = "terraform-demo-launch-template-ec2"
  description   = "This is test lc template"
  image_id      = "ami-0cc293023f983ed53"
  instance_type = "t2.micro"
  ebs_optimized = false

  iam_instance_profile = {
    name = ""
  }
  
  vpc_security_group_ids = ["${aws_security_group.demo-terraform-security-group.id}"]

  monitoring {
    enabled = false
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "terraform-demo-launch-template-ec2"
    }
  }

  # user_data = "${base64encode("${data.template_file.asg_userdata.rendered}")}"
}
