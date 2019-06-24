# Glboal
variable "region" {
  description = "AWS region that will be used to create resources in."
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "vpc CIDR range"
  default     = "198.19.0.0/16"
}
