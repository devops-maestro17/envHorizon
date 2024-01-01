resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "App VPC-${var.environment_name}"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = element(var.public_subnets_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet-${count.index + 1}-${var.environment_name}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet-${count.index + 1}-${var.environment_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "App VPC IGW-${var.environment_name}"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table-${var.environment_name}"
  }
}

resource "aws_route_table_association" "rta" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "app_sg" {
  name   = "app"
  vpc_id = aws_vpc.app_vpc.id

  ingress {
    description = "HTTP Access"
    from_port   = var.ingress_from_port["port_1"]
    to_port     = var.ingress_from_port["port_2"]
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_block
  }

  ingress {
    description = "TCP Access"
    from_port   = var.ingress_from_port["port_2"]
    to_port     = var.ingress_from_port["port_2"]
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "App-SG-${var.environment_name}"
  }
}

