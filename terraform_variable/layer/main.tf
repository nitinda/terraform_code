terraform {
  required_version = ">= 0.11.7"
}


# module "var_test" {
#   source = "../module"
#   region = "${var.region}"
# }



locals {
  subnet_ids = ["subnet-1", "subnet-2", "subnet-3"]
  eips       = ["eip-1", "eip-2", "eip-3"]
  test       = {
    on = "asdasdf"
    off = "q41234123"
  }
}

# resource "null_resource" "subnet_mappings" {
#   count = "${length(local.subnet_ids)}"

#   triggers {
#     subnet_id     = "${element(local.subnet_ids, count.index)}"
#     allocation_id = "${element(local.eips, count.index)}"
#   }
# }




# output "subnet_mappings" {
#   value = "${null_resource.subnet_mappings.*.triggers}"
# }