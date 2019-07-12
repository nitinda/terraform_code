data "template_file" "foo" {
    template = "${file("${path.module}/foo.tpl")}"
    vars = {
      region = "${var.region}"
    }   
}
