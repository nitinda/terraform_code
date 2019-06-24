provider "aws" {
    alias   = "shared_services"
    region  = "${var.region}"
    # version = "2.8"
    # assume_role {
    #     role_arn = "arn:aws:iam::735276988266:role/uki_iam_role_nitin_test"
    # }
}