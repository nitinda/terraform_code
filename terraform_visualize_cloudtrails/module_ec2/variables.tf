variable "vpc_zone_identifier" {
  type = "list"
  description = ""
}

variable "vpc_security_group_ids" {
  description = ""
}

variable "public_subnets" {
  description = "description"
  type = "list"
}


#### ALB

variable "acm_domain_name" {
  description = "description"
}

variable "vpc_id" {
  description = "description"
}


# data "aws_acm_certificate" "demo-acm-certificate" {
#   statuses = ["ISSUED"]
#   types    = ["AMAZON_ISSUED"]
#   domain   = "${var.acm_domain_name}"
# }
