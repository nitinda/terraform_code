resource "aws_flow_log" "demo-vpc-flowlog" {
  iam_role_arn    = "${aws_iam_role.demo-iam-role-vpc-flowlog.arn}"
  log_destination = "${var.log_destination_arn}"
  traffic_type    = "ALL"
  vpc_id          = "${var.vpc_id}"
}