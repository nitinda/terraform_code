output "es_endpoint" {
  value = "${aws_elasticsearch_domain.demo-es-domain.endpoint}"
}

output "kibana_endpoint" {
  value = "${aws_elasticsearch_domain.demo-es-domain.kibana_endpoint}"
}
