resource "aws_vpc" "vpc" {
  cidr_block = "${var.cird}"
  assign_generated_ipv6_cidr_block = "${var.ipv6}"
  enable_dns_support = true
}
data "aws_vpc" "vpc" {
    id = "${aws_vpc.vpc.id}"
}
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "public" {
    count = "${length(var.avz)}"
    vpc_id = "${aws_vpc.vpc.id}"
    availability_zone = "${element(var.avz, count.index)}"
    cidr_block = "${cidrsubnet(data.aws_vpc.vpc.cidr_block, 8, count.index)}"
}
resource "aws_default_route_table" "internet" {
    default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
}

output "aws_vpc_id" {
    value = "${aws_vpc.vpc.id}"
}