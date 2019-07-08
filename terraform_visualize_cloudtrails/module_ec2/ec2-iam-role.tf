resource "aws_iam_role" "demo-iam-role-ec2" {
  name = "terraform-demo-iam-role-ec2"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-ec2-AmazonEC2RoleforSSM" {
  role       = "${aws_iam_role.demo-iam-role-ec2.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-ec2-AmazonSSMAutomationRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
  role       = "${aws_iam_role.demo-iam-role-ec2.name}"
}

resource "aws_iam_instance_profile" "demo-iam-instance-profile-ec2" {
  name = "terraform-demo-instane-profile-ec2"
  role = "${aws_iam_role.demo-iam-role-ec2.name}"
}

