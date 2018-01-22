//resource "aws_vpc" "vpc" {
//  cidr_block = "10.0.0.0/16"
//  enable_dns_hostnames = true
//  enable_dns_support = true
//
//  tags {
//    Name = "VPC ${var.environment_name}"
//    resource_group = "${var.environment_name}"
//  }
//}
//
//resource "aws_internet_gateway" "internet_gateway" {
//  vpc_id = "${aws_vpc.vpc.id}"
//
//  tags {
//    Name = "IGW ${var.environment_name}"
//    resource_group = "${var.environment_name}"
//  }
//}

data "aws_availability_zones" "availability_zones" {}

resource "aws_subnet" "public_subnets" {
  vpc_id = "vpc-029df065" # AP_TODO: using default VPC for now. Maybe create a new one or use data?
  availability_zone = "${data.aws_availability_zones.availability_zones.names[count.index]}"
  cidr_block = "172.31.96.0/28" # AP_TODO: Make it a variable
  map_public_ip_on_launch = true

  tags {
    Name = "${var.environment_name} public subnet ${count.index + 1}"
    resource_group = "${var.environment_name}"
  }
}

//resource "aws_route_table" "public_routing_tables" {
//  vpc_id = "vpc-029df065"
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = "${var.internet_gw_id}"
//  }
//
//  tags {
//    Name = "${var.environment_name} public ${var.subnet_adjective} subnets routing table ${count.index + 1}"
//    resource_group = "${var.environment_name}"
//  }
//}

resource "aws_route_table_association" "public_associations" {
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "rtb-4d5ea12b"
}

resource "aws_security_group" "ecs_task" {
  name_prefix = "${var.environment_name}-ecs-task"

  vpc_id = "vpc-029df065"

  # Accept all public HTTPS traffic
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  # Allows all outbound traffic
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "tcp"
  }

  tags {
    Name = "${var.environment_name} ecs task security group"
    resource_group = "${var.environment_name}"
  }
}
