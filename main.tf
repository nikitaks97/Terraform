resource "aws_vpc" "main" {
  cidr_block   = var.vpc_cidr

  tags = {
    Name = "vpc-1"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "pvt-subnet1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gw-1"
  }
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.igw.id
  destination_cidr_block    = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.igw.id
}
