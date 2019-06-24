resource "aws_iam_role" "demo-iam-role-cloudtrail-cloudwatch-log-group" {
  name = "terraform-demo-iam-role-cloudwatch-log-group"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo-iam-role-policy-cloudtrail-cloudwatch-log" {
  name = "terraform-demo-iam-role-policy-cloudwatch-log"
  role = "${aws_iam_role.demo-iam-role-cloudtrail-cloudwatch-log-group.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailPutLogEvents",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:CreateLogStream"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}