output "s3_bucket_arn" {
  value = "${aws_s3_bucket.demo-s3.arn}"
}

output "s3_bucket_name" {
  value = "${aws_s3_bucket.demo-s3.id}"
}
