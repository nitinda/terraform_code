terraform {
  required_version = ">= 0.11.7"
}


module "aws_resources_module" {
  source  = "../module"

  providers = {
    "aws"  = "aws.shared_services"
  }
}