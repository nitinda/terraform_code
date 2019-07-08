output "demo_subnet_private" {
  value = "${aws_subnet.demo-subnet-private.*.id}"
}

output "demo_subnet_public" {
  value = "${aws_subnet.demo-subnet-public.*.id}"
}

output "demo_vpc_cidr" {
  value = "${aws_vpc.demo-vpc.cidr_block}"
}

output "demo_security_group" {
  value = "${aws_security_group.demo-security-group.id}"
}

output "demo_vpc_id" {
  value = "${aws_vpc.demo-vpc.id}"
}