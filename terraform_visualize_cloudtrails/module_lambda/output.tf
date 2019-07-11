output "lambda_function_cloudtrail_logstoelasticsearch_arn" {
  value = "${aws_lambda_function.demo-lambda-cloudtrail-logstoelasticsearch.arn}"
}

output "lambda_function_vpcflow_logstoelasticsearch_arn" {
  value = "${aws_lambda_function.demo-lambda-vpcflow-logstoelasticsearch.arn}"
}

output "lambda_cwlpolicyforstreaming_role_arn" {
  value = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.arn}"
}
