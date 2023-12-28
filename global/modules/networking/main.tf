resource "aws_vpc" "app-vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.app-vpc.id
  cidr_block = var.subnet_1_cidr
  availability_zone = var.subnet_1_az
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.app-vpc.id
  cidr_block = var.subnet_2_cidr
  availability_zone = var.subnet_2_az
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.app-vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta-1" {
  subnet_id = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta-2" {
  subnet_id = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
  name = "web-app-sg"
  vpc_id = aws_vpc.app-vpc.id

  ingress {
    description = "HTTP traffic"
    from_port = var.from_port
    to_port = var.to_port
    protocol = "tcp"
    cidr_blocks = var.sg_cidr
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.sg_cidr
  }

  tags = {
    Name = "web-app-sg"
  }
}