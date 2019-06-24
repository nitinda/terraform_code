
resource "aws_vpc" "demo-terraform-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = "${
    map(
     "Name", "terraform-demo-vpc",
    )
  }"
}

resource "aws_subnet" "demo-terraform-subnet-public" {
  count             = 2
  vpc_id            = "${aws_vpc.demo-terraform-vpc.id}"
  cidr_block        = "172.16.${count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.demo-available.names[count.index]}"

  tags = "${
    map(
     "Name", "terraform-demo-subnet-public-${count.index}",
    )
  }"
}

# resource "aws_subnet" "demo-terraform-subnet-private" {
#   count             = 2
#   vpc_id            = "${aws_vpc.demo-terraform-vpc.id}"
#   cidr_block        = "172.16.${count.index+2}.0/24"
#   availability_zone = "${data.aws_availability_zones.demo-available.names[count.index]}"

#   tags = "${
#     map(
#      "Name", "terraform-demo-subnet-private-${count.index}",
#     )
#   }"
# }

resource "aws_internet_gateway" "demo-terraform-internet-gateway" {
  vpc_id = "${aws_vpc.demo-terraform-vpc.id}"

  tags = {
    Name = "terraform-demo-internet-gateway"
  }
}

# resource "aws_eip" "demo-terraform-eip" {
#   count = 2
#   vpc   = true
#   tags = {
#     Name = "terraform-demo-eip-${count.index}"
#   }
# }

# resource "aws_nat_gateway" "demo-terraform-nat-gateway" {
#   count = 2
#   allocation_id = "${aws_eip.demo-terraform-eip.*.id[count.index]}"
#   subnet_id     = "${aws_subnet.demo-terraform-subnet-public.*.id[count.index]}"
#   depends_on    = ["aws_internet_gateway.demo-terraform-internet-gateway"]

#   tags = {
#     Name = "terraform-demo-nat-gateway-${count.index}"
#   }
# }

# Route Tables and Routes

resource "aws_route_table" "demo-terraform-route-table-dmz" {
  vpc_id = "${aws_vpc.demo-terraform-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-terraform-internet-gateway.id}"
  }

  tags {
    Name = "terraform-demo-route-table-public"
  }
}

resource "aws_route_table_association" "demo-terraform-route-table-association-dmz" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-terraform-subnet-public.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-terraform-route-table-dmz.id}"
}

# resource "aws_route_table" "demo-terraform-route-table-privdmz" {
#   count  = 2
#   vpc_id = "${aws_vpc.demo-terraform-vpc.id}"

#   tags {
#     Name = "terraform-demo-route-table-private-${count.index}"
#   }
# }

# resource "aws_route_table_association" "demo-terraform-route-table-association-privdmz" {
#   count          = 2
#   subnet_id      = "${element(aws_subnet.demo-terraform-subnet-private.*.id, count.index)}"
#   route_table_id = "${aws_route_table.demo-terraform-route-table-privdmz.*.id[count.index]}"
# }

# resource "aws_route" "demo-terraform-privdmz-routes-nat" {
#   count                  = 2
#   route_table_id         = "${aws_route_table.demo-terraform-route-table-privdmz.*.id[count.index]}"
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = "${aws_nat_gateway.demo-terraform-nat-gateway.*.id[count.index]}"
#   depends_on             = ["aws_route_table.demo-terraform-route-table-dmz"]
# }



resource "aws_security_group" "demo-terraform-security-group" {
  name        = "terraform-demo-es-security-group"
  description = "Allow inbound traffic"
  vpc_id      = "${aws_vpc.demo-terraform-vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["62.254.158.10/32","10.33.0.0/16","176.250.66.34/32","172.16.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "terraform-demo-es-security-group"
  }
}


