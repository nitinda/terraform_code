resource "aws_cloudwatch_log_group" "demo-cloudtrail-cloudwatch-log-group" {
    name = "terraform-demo-cloudtrail-cw-log-group"
    retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "demo-vpc-flowlog-cloudwatch-loggroup" {
    name = "terraform-demo-vpc-flowlog-cw-loggroup"
    retention_in_days = 30
}

# resource "aws_cloudwatch_log_subscription_filter" "demo-cloudwatch-log-subscription-filter-cloudtrail-logs" {
#   name            = "terraform-demo-elasticsearch-stream-cloudtrail-logs-subscriptions"
# #   role_arn        = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.arn}"
#   log_group_name  = "${aws_cloudwatch_log_group.demo-cloudtrail-cloudwatch-log-group.name}"
#   filter_pattern  = "AWS CloudTrail"
# #   destination_arn = "${aws_elasticsearch_domain.demo-es-domain.domain_id}"
#   destination_arn = "${aws_lambda_function.demo-lambda-cloudtrail-logstoelasticsearch.arn}"
# #   distribution    = "Random"
#   depends_on = ["aws_lambda_permission.demo-lambda-permission-cloudtrail-logstoelasticsearch"]
# }


# resource "aws_cloudwatch_log_subscription_filter" "demo-cloudwatch-log-subscription-filter-vpcflow-logs" {
#   name            = "terraform-demo-elasticsearch-stream-vpcflow-logs-subscriptions"
# #   role_arn        = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.arn}"
#   log_group_name  = "${aws_cloudwatch_log_group.demo-vpc-flowlog-cloudwatch-loggroup.name}"
#   filter_pattern  = "Amazon VPC Flow Logs"
# #   destination_arn = "${aws_elasticsearch_domain.demo-es-domain.domain_id}"
#   destination_arn = "${aws_lambda_function.demo-lambda-vpcflow-logstoelasticsearch.arn}"
# #   distribution    = "Random"
#   depends_on = ["aws_lambda_permission.demo-lambda-permission-vpcflow-logstoelasticsearch"]
# }