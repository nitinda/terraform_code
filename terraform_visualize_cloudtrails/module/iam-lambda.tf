resource "aws_iam_role" "demo-iam-role-lambda-wiringfunction" {
  name = "terraform-demo-iam-role-lambda-wiringfunction"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "demo-iam-role-policy-lambda-wiringfunction" {
  name = "terraform-demo-iam-role-policy-lambda-wiringfunction"
  role = "${aws_iam_role.demo-iam-role-lambda-wiringfunction.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "cognito-sync:*",
          "cognito-identity:*",
          "cognito-idp:*"
        ],
        "Resource": [
          "*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:PutRetentionPolicy",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ],
        "Resource": [
          "*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "es:*"
        ],
        "Resource": [
          "*"
        ]
      }
  ]
}
EOF
}


##############################################################################


resource "aws_iam_role" "demo-iam-role-lambda-cwlpolicyforstreaming" {
  name = "terraform-demo-iam-role-lambda-cwlpolicyforstreaming"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo-iam-role-policy-lambda-cwlpolicyforstreaming" {
  name = "terraform-demo-iam-role-policy-lambda-cwlpolicyforstreaming"
  role = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": "es:ESHttpPost",
            "Resource": "arn:aws:es:*:*:*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "demo-iam-role-policy-attachment-lambdavpcaccessexecution" {
  role       = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}