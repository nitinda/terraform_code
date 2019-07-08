resource "aws_iam_role" "demo-iam-role-vpc-flowlog" {
  name = "terraform-demo-iam-role-vpc-flowlog"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo-iam-role-policy-vpc-flowlog" {
  name = "terraform-demo-iam-role-policy-vpc-flowlog"
  role = "${aws_iam_role.demo-iam-role-vpc-flowlog.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}