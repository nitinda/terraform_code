# resource "aws_cloudwatch_log_subscription_filter" "demo-cloudwatch-log-subscription-filter-cloudtrail-logs" {
#   name            = "terraform-demo-elasticsearch-stream-cloudtrail-logs-subscriptions"
# #   role_arn        = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.arn}"
#   log_group_name  = "${var.cloud_watch_logs_group_name_cloudtrail}"
#   filter_pattern  = "AWS CloudTrail"
# #   destination_arn = "${aws_elasticsearch_domain.demo-es-domain.domain_id}"
#   destination_arn = "${var.lambda_function_cloudtrail_logstoelasticsearch_arn}"
# #   distribution    = "Random"
# }

resource "aws_cloudwatch_log_subscription_filter" "demo-cloudwatch-log-subscription-filter-vpcflow-logs" {
  name            = "terraform-demo-elasticsearch-stream-vpcflow-logs-subscriptions"
  # role_arn        = "${var.lambda_cwlpolicyforstreaming_role_arn}"
  log_group_name  = "${var.cloud_watch_logs_group_name_vpcflow}"
  filter_pattern  = "[version, account_id, interface_id, srcaddr != \"-\", dstaddr != \"-\", srcport != \"-\", dstport != \"-\", protocol, packets, bytes, start, end, action, log_status]",
#   destination_arn = "${aws_elasticsearch_domain.demo-es-domain.domain_id}"
  destination_arn = "${var.lambda_function_vpcflow_logstoelasticsearch_arn}"
  distribution = "ByLogStream"
}