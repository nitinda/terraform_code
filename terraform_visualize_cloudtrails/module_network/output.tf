output "demo-subnet-private" {
  value = "${aws_subnet.demo-subnet-private.*.id}"
}

output "demo-subnet-public" {
  value = "${aws_subnet.demo-subnet-private.*.id}"
}

output "demo-vpc-cidr" {
  value = "${aws_vpc.demo-vpc.cidr_block}"
}

output "demo-security-group" {
  value = "${aws_security_group.demo-security-group.id}"
}
