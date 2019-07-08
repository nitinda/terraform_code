resource "aws_iam_role" "demo-iam-role-es" {
  name = "terraform-demo-iam-role-es"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo-iam-role-policy-es" {
  name = "terraform-demo-iam-role-policy-es"
  role = "${aws_iam_role.demo-iam-role-es.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVpcs",
        "cognito-identity:ListIdentityPools",
        "cognito-idp:ListUserPools"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:GetRole",
        "iam:PassRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-es-attachment-escognitoaccess" {
  role       = "${aws_iam_role.demo-iam-role-es.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonESCognitoAccess"
}