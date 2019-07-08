data "aws_availability_zones" "demo-available" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}


resource "random_uuid" "demo-random" { }