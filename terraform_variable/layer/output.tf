# output "variable_test" {
#   value = "${local.maintenance_window_iam_role_arn}"
# }

# output "test_list" {
#   value = "${join(",", "${formatlist("%s/32",var.test)}")}"
# }

# output "layer_file_out" {
#   value = "${module.var_test.file_out}"
# }

# output "layer_key" {
#   value = "${base64encode("${var.key}")}"
# }



locals {
    schedule_expression_test {
        on = "sdasdasd"
        off = "asdasdfasdasda"
    }
    schedule_expression_prod {
        on = "2312341234"
        off = "132412341"
    }
    
    schedule_expression {
        TEST = "${local.schedule_expression_test}"
        PROD = "${local.schedule_expression_prod}"
    }
}



output "test" {
  value = "${local.schedule_expression["PROD"]}"
}
