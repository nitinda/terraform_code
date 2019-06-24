resource "aws_lambda_function" "demo-lambda-wiringfunction" {
    filename         = "../module/lambda_function/terraform-demo-lambda-wiringfunction.zip"
    function_name    = "terraform-demo-lambda-wiringfunction"
    description      = "Wires together Cognito and Amazon ES"
    role             = "${aws_iam_role.demo-iam-role-lambda-wiringfunction.arn}"
    handler          = "index.handler"
    source_code_hash = "${filebase64sha256("../module/lambda_function/terraform-demo-lambda-wiringfunction.zip")}"
    runtime          = "python2.7"
    timeout          = "60"
    memory_size      = "128"
    
    environment {
        variables = {
            COGNITOUSERPOOL = "${aws_cognito_user_pool.demo-cognoti-user-pool.id}"
        }
    }
}

# resource "aws_lambda_permission" "demo-lambda-permission-wiringfunction" {
#   statement_id  = "AllowExecutionFromCognito"
#   action        = "lambda:InvokeFunction"
#   function_name = "${aws_lambda_function.demo-lambda-wiringfunction.function_name}"
#   principal     = "cognito-sync.amazonaws.com"
# }


resource "aws_lambda_function" "demo-lambda-logstoelasticsearch" {
    filename         = "../module/lambda_function/terraform-demo-lambda-logstoelasticsearch.zip"
    function_name    = "terraform-demo-lambda-logstoelasticsearch"
    description      = "CloudWatch Logs to Amazon ES streaming"
    role             = "${aws_iam_role.demo-iam-role-lambda-cwlpolicyforstreaming.arn}"
    handler          = "index.handler"
    source_code_hash = "${filebase64sha256("../module/lambda_function/terraform-demo-lambda-logstoelasticsearch.zip")}"
    runtime          = "nodejs8.10"
    timeout          = "60"
    memory_size      = "128"

    environment {
        variables = {
            es_endpoint = "${aws_elasticsearch_domain.demo-es-domain.endpoint}"
        }
    }
}

resource "aws_lambda_permission" "demo-lambda-permission-logstoelasticsearch" {
  statement_id = "terraform-demo-lambda-permission-CloudWatchAllow"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.demo-lambda-logstoelasticsearch.arn}"
  principal = "logs.eu-central-1.amazonaws.com"
  source_arn = "${aws_cloudwatch_log_group.demo-cloudtrail-cloudwatch-log-group.arn}"
}