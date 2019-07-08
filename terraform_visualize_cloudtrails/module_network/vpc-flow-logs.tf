# resource "aws_flow_log" "demo-vpc-flowlog" {
#   iam_role_arn    = "${aws_iam_role.demo-vpc-flowlog-iam-role.arn}"
#   log_destination = "${aws_cloudwatch_log_group.demo-vpc-flowlog-cloudwatch-loggroup.arn}"
#   traffic_type    = "ALL"
#   vpc_id          = "${aws_vpc.demo-vpc.id}"
# }