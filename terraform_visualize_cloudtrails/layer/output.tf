output "kibana_endpoint" {
  value = "https://${module.aws_resources_module_es.kibana_endpoint}"
}