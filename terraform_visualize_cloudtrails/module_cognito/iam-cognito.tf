resource "aws_iam_role" "demo-iam-role-cognito" {
  name = "terraform-iam-role-cognito-authenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.demo-cognito-identity-pool.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo-iam-role-policy-cognito" {
  name = "terraform-demo-iam-role-policy-cognito"
  role = "${aws_iam_role.demo-iam-role-cognito.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_cognito_identity_pool_roles_attachment" "demo-iam-role-attachment-cognito" {
  identity_pool_id = "${aws_cognito_identity_pool.demo-cognito-identity-pool.id}"

  roles = {
    "authenticated" = "${aws_iam_role.demo-iam-role-cognito.arn}"
  }
}