output "file_out" {
  value = "${data.template_file.foo.rendered}"
}
