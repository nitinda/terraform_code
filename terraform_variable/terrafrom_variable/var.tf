variable "region" {
  description = "AWS region that will be used to create resources in."
  default     = "eu-central-1"
}


locals {
  local_test {    
    PROD = "${var.region}"
  }

  maintenance_window_iam_role_arn = "${local.local_test[terraform.workspace]}"
}