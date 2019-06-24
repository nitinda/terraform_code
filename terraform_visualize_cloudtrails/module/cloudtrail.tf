resource "aws_cloudtrail" "demo-cloudtrail" {
  name                          = "terrafrom-demo-cloudtrail"
  s3_bucket_name                = "${aws_s3_bucket.demo-s3.id}"
  include_global_service_events = false
 
  event_selector {
    read_write_type           = "All"
    include_management_events = true
 
    data_resource {
      type   = "AWS::S3::Object"
      values = ["${aws_s3_bucket.demo-s3.arn}/"]
    }
  }
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.demo-cloudtrail-cloudwatch-log-group.arn}"
  cloud_watch_logs_role_arn  = "${aws_iam_role.demo-iam-role-cloudtrail-cloudwatch-log-group.arn}"
}
