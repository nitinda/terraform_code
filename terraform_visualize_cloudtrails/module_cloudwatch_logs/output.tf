output "cloud_watch_logs_group_arn_cloudtrail" {
  value = "${aws_cloudwatch_log_group.demo-cloudtrail-cloudwatch-log-group.arn}"
}

output "cloud_watch_logs_group_arn_vpcflow" {
  value = "${aws_cloudwatch_log_group.demo-vpc-flowlog-cloudwatch-loggroup.arn}"
}

output "cloud_watch_logs_role_arn" {
  value = "${aws_iam_role.demo-iam-role-cloudtrail-cloudwatch-log-group.arn}"
}


output "cloud_watch_logs_group_name_cloudtrail" {
  value = "${aws_cloudwatch_log_group.demo-cloudtrail-cloudwatch-log-group.name}"
}

output "cloud_watch_logs_group_name_vpcflow" {
  value = "${aws_cloudwatch_log_group.demo-vpc-flowlog-cloudwatch-loggroup.name}"
}
