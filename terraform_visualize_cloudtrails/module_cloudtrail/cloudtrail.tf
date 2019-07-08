resource "aws_cloudtrail" "demo-cloudtrail" {
  name                          = "terrafrom-demo-cloudtrail"
  s3_bucket_name                = "${var.s3_bucket_name}"
  include_global_service_events = false
 
  event_selector {
    read_write_type           = "All"
    include_management_events = true
 
    data_resource {
      type   = "AWS::S3::Object"
      values = ["${var.s3_bucket_arn}/"]
    }
  }
  cloud_watch_logs_group_arn = "${var.cloud_watch_logs_group_arn_cloudtrail}"
  cloud_watch_logs_role_arn  = "${var.cloud_watch_logs_role_arn}"
}