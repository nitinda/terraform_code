resource "aws_elasticsearch_domain" "demo-es-domain" {
  domain_name           = "terraform-demo-es-domain"
  elasticsearch_version = "6.7"

  cluster_config {
    instance_type  = "t2.small.elasticsearch"
    instance_count = 2
    dedicated_master_enabled = true
    zone_awareness_enabled = true
    dedicated_master_type = "t2.small.elasticsearch"
    dedicated_master_count = 3
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  ebs_options {
      ebs_enabled = true
      volume_type = "gp2"
      volume_size = "10"
  }

  # vpc_options {
  #     subnet_ids = ["${var.es_subnet_ids}"]
  #     security_group_ids = ["${var.security_group_ids}"]
  # }

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
        "Action": "es:*",
        "Principal": {
          "AWS": [
            "${var.cognito_iam_role_arn}"
          ]
        },
        "Effect": "Allow",
        "Resource": [
          "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/terraform*"
        ]
      }
    ]
}
POLICY

  depends_on = [
    "aws_iam_service_linked_role.es"
  ]

  cognito_options = {
    enabled = true
    user_pool_id = "${var.cognito_user_pool_id}"
    identity_pool_id = "${var.cognito_identity_pool_id}"
    role_arn = "${aws_iam_role.demo-iam-role-es.arn}"
  }
}