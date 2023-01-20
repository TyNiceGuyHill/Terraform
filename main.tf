terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.28.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}




# create VPC; CIDR 10.0.0.0/16
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = "${var.default_tags.env}"
  }
}

# public subnets 10.0.0.0/24
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.vpc_id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.default_tags.env}-Public-Subnet"
  }
}
