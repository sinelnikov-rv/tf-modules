resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
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
resource "aws_security_group" "web" {
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "db" {
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
      from_port = "3306"
      to_port = "3306"
      protocol = "tcp"
      security_groups = ["${aws_security_group.web.id}"]
  }
  egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_default_route_table" "internet" {
    default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
}
resource "aws_db_subnet_group" "db_subnets" {
  subnet_ids = ["${aws_subnet.public.*.id}"]
}

