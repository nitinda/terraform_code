
resource "aws_vpc" "demo-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = "${
    map(
     "Name", "terraform-demo-vpc",
    )
  }"
}

resource "aws_subnet" "demo-subnet-public" {
  count             = 2
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "172.16.${count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.demo-available.names[count.index]}"

  tags = "${
    map(
     "Name", "terraform-demo-subnet-public-${count.index}",
    )
  }"
}

resource "aws_subnet" "demo-subnet-private" {
  count             = 2
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "172.16.${count.index+2}.0/24"
  availability_zone = "${data.aws_availability_zones.demo-available.names[count.index]}"

  tags = "${
    map(
     "Name", "terraform-demo-subnet-private-${count.index}",
    )
  }"
}

resource "aws_internet_gateway" "demo-internet-gateway" {
  vpc_id = "${aws_vpc.demo-vpc.id}"

  tags = {
    Name = "terraform-demo-internet-gateway"
  }
}

resource "aws_eip" "demo-eip" {
  count = 2
  vpc   = true
  tags = {
    Name = "terraform-demo-eip-${count.index}"
  }
}

resource "aws_nat_gateway" "demo-nat-gateway" {
  count = 2
  allocation_id = "${aws_eip.demo-eip.*.id[count.index]}"
  subnet_id     = "${aws_subnet.demo-subnet-public.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.demo-internet-gateway"]

  tags = {
    Name = "terraform-demo-nat-gateway-${count.index}"
  }
}

# Route Tables and Routes

resource "aws_route_table" "demo-route-table-dmz" {
  vpc_id = "${aws_vpc.demo-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-internet-gateway.id}"
  }

  tags {
    Name = "terraform-demo-route-table-public"
  }
}

resource "aws_route_table_association" "demo-route-table-association-dmz" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-subnet-public.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-route-table-dmz.id}"
}

resource "aws_route_table" "demo-route-table-privdmz" {
  count  = 2
  vpc_id = "${aws_vpc.demo-vpc.id}"

  tags {
    Name = "terraform-demo-route-table-private-${count.index}"
  }
}

resource "aws_route_table_association" "demo-route-table-association-privdmz" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-subnet-private.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-route-table-privdmz.*.id[count.index]}"
}

resource "aws_route" "demo-privdmz-routes-nat" {
  count                  = 2
  route_table_id         = "${aws_route_table.demo-route-table-privdmz.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.demo-nat-gateway.*.id[count.index]}"
  depends_on             = ["aws_route_table.demo-route-table-dmz"]
}

