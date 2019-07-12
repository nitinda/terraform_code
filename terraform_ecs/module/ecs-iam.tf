resource "aws_iam_role" "ecs-service-role" {
  name               = "terraform-demo-ecs-service-role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-service-policy.json}"
}


resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role       = "${aws_iam_role.ecs-service-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "demo-iam-role-policy-ecs-service-role-inline-policy" {
  name = "terraform-demo-ecs-service-role-inline-policy"
  role = "${aws_iam_role.ecs-service-role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:AttachVolume",
                "ec2:CopySnapshot",
                "ec2:ImportVolume",
                "ec2:DeleteSnapshot",
                "ec2:ModifyVolumeAttribute",
                "ec2:DeleteTags",
                "ec2:DescribeVolumesModifications",
                "ec2:DescribeSnapshots",
                "ec2:DeleteVolume",
                "ec2:DescribeVolumeStatus",
                "ec2:ModifySnapshotAttribute",
                "ec2:DescribeVolumes",
                "ec2:CreateSnapshot",
                "ec2:DetachVolume",
                "ec2:ModifyVolume",
                "ec2:DescribeSnapshotAttribute",
                "ec2:DescribeTags",
                "ec2:CreateTags",
                "ec2:ResetSnapshotAttribute",
                "ec2:ImportSnapshot",
                "ec2:DescribeVolumeAttribute",
                "ec2:CreateVolume",
                "ec2:EnableVolumeIO",
                "ec2:DescribeImportSnapshotTasks",
                "ec2:CreateSnapshots"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        }
    ]
}
EOF
}





resource "aws_iam_role" "ecs-instance-role" {
  name               = "terraform-demo-ecs-instance-role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-instance-policy.json}"
}

data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = "${aws_iam_role.ecs-instance-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment-SSM" {
  role       = "${aws_iam_role.ecs-instance-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment-Cloutwatch" {
  role       = "${aws_iam_role.ecs-instance-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudTrailFullAccess"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "terraform-demo-ecs-instance-profile"
  path = "/"
  role = "${aws_iam_role.ecs-instance-role.id}"

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "aws_iam_role_policy" "demo-iam-role-policy-ecs-instance-profile" {
  name = "terraform-demo-ecs-role-inline-policy"
  role = "${aws_iam_role.ecs-instance-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
                "ec2:AttachVolume",
                "ec2:CopySnapshot",
                "ec2:ImportVolume",
                "ec2:DeleteSnapshot",
                "ec2:ModifyVolumeAttribute",
                "ec2:DeleteTags",
                "ec2:DescribeVolumesModifications",
                "ec2:DescribeSnapshots",
                "ec2:DeleteVolume",
                "ec2:DescribeVolumeStatus",
                "ec2:ModifySnapshotAttribute",
                "ec2:DescribeVolumes",
                "ec2:CreateSnapshot",
                "ec2:DetachVolume",
                "ec2:ModifyVolume",
                "ec2:DescribeSnapshotAttribute",
                "ec2:DescribeTags",
                "ec2:CreateTags",
                "ec2:ResetSnapshotAttribute",
                "ec2:ImportSnapshot",
                "ec2:DescribeVolumeAttribute",
                "ec2:CreateVolume",
                "ec2:EnableVolumeIO",
                "ec2:DescribeImportSnapshotTasks",
                "ec2:CreateSnapshots"
        ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
        "Sid": "AllowKMS",
        "Action": [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
        ],
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "kms:CreateGrant"
        ],
        "Resource": "*",
        "Condition": {
            "Bool": {
                "kms:GrantIsForAWSResource": true
            }
        }
    }
  ]
}
EOF
}










resource "aws_iam_role" "demo-ecs-task-execution-role" {
  name               = "terraform-demo-ecs-task-execution-role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-service-policy.json}"
}


resource "aws_iam_role_policy_attachment" "demo-ecs-task-execution-role-attachment" {
  role       = "${aws_iam_role.demo-ecs-task-execution-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "demo-ecs-task-execution-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "demo-iam-role-policy-ecs-task-execution-role-inline-policy" {
  name = "terraform-demo-ecs-task-execution-role-inline-policy"
  role = "${aws_iam_role.demo-ecs-task-execution-role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        }
    ]
}
EOF
}