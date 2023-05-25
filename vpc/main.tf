#creating the VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "VPC"
    }
}

#for creating the public subnets
resource "aws_subnet" "public_subnet" {
    for_each = var.public_subnet_cidr
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    tags = {
        Name = each.key
    }
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
}

#for creating the private subnets
resource "aws_subnet" "private_subnet" {
    for_each = var.private_subnet_cidr
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    tags = {
        Name = each.key
    }
    availability_zone = "us-east-1a"
}

#creating internet gateway
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "vpc_igw"
    }
}

#creating route table for public subnets
resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.all_route
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "route_table_public"
    }
}

#creating elastic ips for nat gateway
resource "aws_eip" "nat_ips" {
  vpc = true
  tags = {
    Name = "nat_ips"
  }
}

#creating nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ips.id
  subnet_id = aws_subnet.private_subnet.id
}

#creating route table for private subnets
resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.all_route
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "route_table_private"
    }
}

#creating route table association for private subnets
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

#creating route table association for public subnets
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}