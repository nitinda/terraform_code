variable "region" {
  description = "AWS region that will be used to create resources in."
  default     = "eu-central-1"
}


# locals {
#   local_test {    
#     PROD = "${var.region}"
#   }

#   maintenance_window_iam_role_arn = "${local.local_test[terraform.workspace]}"
# }

variable "test" {
  default = [ "52.58.167.180", "18.194.67.31" ]
}

variable "key" {
  default = "1150c952528f8e6ebd6c30c0bc97394139"
}
