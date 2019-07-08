terraform {
  required_version = ">= 0.11.7"
}


module "aws_resources_module_network" {
  source  = "../module_network"

  providers = {
    "aws"  = "aws.shared_services"
  }
}


module "aws_resources_module_ec2" {
  source  = "../module_ec2"

  providers = {
    "aws"  = "aws.shared_services"
  }

  vpc_zone_identifier = "${module.aws_resources_module_network.demo-subnet-private}"
  vpc_security_group_ids = "${module.aws_resources_module_network.demo-security-group}"
}

module "aws_resources_module_cognito" {
  source  = "../module_cognito"

  providers = {
    "aws"  = "aws.shared_services"
  }
}

module "aws_resources_module_s3" {
  source  = "../module_s3"

  providers = {
    "aws"  = "aws.shared_services"
  }
}


module "aws_resources_module_cloudwatch_logs" {
  source  = "../module_cloudwatch_logs"

  providers = {
    "aws"  = "aws.shared_services"
  }
}

module "aws_resources_module_cloudtrail" {
  source  = "../module_cloudtrail"

  providers = {
    "aws"  = "aws.shared_services"
  }
  s3_bucket_arn = "${module.aws_resources_module_s3.s3_bucket_arn}"
  s3_bucket_name = "${module.aws_resources_module_s3.s3_bucket_name}"
  cloud_watch_logs_group_arn_cloudtrail = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_group_arn_cloudtrail}"
  cloud_watch_logs_role_arn = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_role_arn}"
}

module "aws_resources_module_es" {
  source  = "../module_es"

  providers = {
    "aws"  = "aws.shared_services"
  }

  es_subnet_ids = "${module.aws_resources_module_network.demo-subnet-public}"
  security_group_ids = "${module.aws_resources_module_network.demo-security-group}"
  cognito_user_pool_id = "${module.aws_resources_module_cognito.cognito_user_pool_id}"
  cognito_identity_pool_id = "${module.aws_resources_module_cognito.cognito_identity_pool_id}"
}

module "aws_resources_module_lambda" {
  source  = "../module_lambda"

  providers = {
    "aws"  = "aws.shared_services"
  }
  cognito_user_pool_id = "${module.aws_resources_module_cognito.cognito_user_pool_id}"
  es_endpoint = "${module.aws_resources_module_es.es_endpoint}"
  cloud_watch_logs_group_arn_cloudtrail = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_group_arn_cloudtrail}"
  cloud_watch_logs_group_arn_vpcflow = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_group_arn_vpcflow}"
  cloud_watch_logs_role_arn = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_role_arn}"
}

module "aws_resources_module_cloudwatch_log_subscription" {
  source  = "../module_cloudwatch_log_subscription"

  providers = {
    "aws"  = "aws.shared_services"
  }
  cloud_watch_logs_group_name_cloudtrail = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_group_name_cloudtrail}"
  cloud_watch_logs_group_name_vpcflow = "${module.aws_resources_module_cloudwatch_logs.cloud_watch_logs_group_name_vpcflow}"
  lambda_function_vpcflow_logstoelasticsearch_arn = "${module.aws_resources_module_lambda.lambda_function_vpcflow_logstoelasticsearch_arn}"
  lambda_function_cloudtrail_logstoelasticsearch_arn = "${module.aws_resources_module_lambda.lambda_function_cloudtrail_logstoelasticsearch_arn}"
}