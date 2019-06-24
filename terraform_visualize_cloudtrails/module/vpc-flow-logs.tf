resource "aws_iam_role" "demo-vpc-flowlog-iam-role" {
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

resource "aws_iam_role_policy" "demo-vpc-flowlog-iam-role-policy" {
  name = "terraform-demo-iam-role-policy-vpc-flowlog"
  role = "${aws_iam_role.demo-vpc-flowlog-iam-role.id}"

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

resource "aws_flow_log" "demo-vpc-flowlog" {
  iam_role_arn    = "${aws_iam_role.demo-vpc-flowlog-iam-role.arn}"
  log_destination = "${aws_cloudwatch_log_group.demo-vpc-flowlog-cloudwatch-loggroup.arn}"
  traffic_type    = "ALL"
  vpc_id          = "${aws_vpc.demo-terraform-vpc.id}"
}