resource "aws_lambda_function" "demo-lambda-wiringfunction" {
    filename         = "../module_lambda/lambda_function/terraform-demo-lambda-wiringfunction.zip"
    function_name    = "terraform-demo-lambda-wiringfunction"
    description      = "Wires together Cognito and Amazon ES"
    role             = "${aws_iam_role.demo-iam-role-lambda-wiringfunction.arn}"
    handler          = "index.handler"
    source_code_hash = "${filebase64sha256("../module_lambda/lambda_function/terraform-demo-lambda-wiringfunction.zip")}"
    runtime          = "python2.7"
    timeout          = "60"
    memory_size      = "128"
    
    environment {
        variables = {
            COGNITOUSERPOOL = "${var.cognito_user_pool_id}"
        }
    }
}


resource "aws_lambda_function" "demo-lambda-cloudtrail-logstoelasticsearch" {
    filename         = "../module_lambda/lambda_function/terraform-demo-lambda-cloudtrail-logstoelasticsearch.zip"
    function_name    = "terraform-demo-lambda-logstoelasticsearch"
    description      = "CloudWatch Logs to Amazon ES streaming"
    role             = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.arn}"
    handler          = "index.handler"
    source_code_hash = "${filebase64sha256("../module_lambda/lambda_function/terraform-demo-lambda-cloudtrail-logstoelasticsearch.zip")}"
    runtime          = "nodejs8.10"
    timeout          = "60"
    memory_size      = "128"

    environment {
        variables = {
            es_endpoint = "${var.es_endpoint}"
        }
    }
}

resource "aws_lambda_permission" "demo-lambda-permission-cloudtrail-logstoelasticsearch" {
  statement_id = "terraform-demo-lambda-permission-cloudtrail-logs-cloudwatch-allow"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.demo-lambda-cloudtrail-logstoelasticsearch.arn}"
  principal = "logs.eu-central-1.amazonaws.com"
  source_arn = "${var.cloud_watch_logs_group_arn_cloudtrail}"
}