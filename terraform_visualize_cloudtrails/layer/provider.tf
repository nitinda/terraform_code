provider "aws" {
    alias   = "shared_services"
    region  = "${var.region}"
}