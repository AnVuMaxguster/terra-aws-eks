resource "aws_vpc" "testvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "basic-vpc"
  }
}

resource "aws_subnet" "testvpc-pub-sub1" {
  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "basic-vpc-pub-sub-1"
  }
}

resource "aws_subnet" "testvpc-pub-sub2" {
  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "basic-vpc-pub-sub-2"
  }
}

resource "aws_subnet" "testvpc-pub-sub3" {
  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "basic-vpc-pub-sub-3"
  }
}

resource "aws_subnet" "testvpc-priv-sub1" {
  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "basic-vpc-priv-sub-1"
  }
}

resource "aws_subnet" "testvpc-priv-sub2" {
  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "basic-vpc-priv-sub-2"
  }
}

resource "aws_subnet" "testvpc-priv-sub3" {
  vpc_id                  = aws_vpc.testvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "basic-vpc-priv-sub-3"
  }
}

resource "aws_internet_gateway" "testvpc-GW" {
  vpc_id = aws_vpc.testvpc.id
  tags = {
    Name = "basic-vpc-gateway"
  }
}

resource "aws_route_table" "testvpc-RT" {
  vpc_id = aws_vpc.testvpc.id

  # Default route to the Internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testvpc-GW.id
  }

  # Routing between instances within the same VPC is handled automatically by AWS

  tags = {
    Name = "basic-vpc-routetable"
  }
}

# Associate public subnets to the above route table
resource "aws_route_table_association" "testvpc-pub-sub1-a" {
  subnet_id      = aws_subnet.testvpc-pub-sub1.id
  route_table_id = aws_route_table.testvpc-RT.id
}

resource "aws_route_table_association" "testvpc-pub-sub2-a" {
  subnet_id      = aws_subnet.testvpc-pub-sub2.id
  route_table_id = aws_route_table.testvpc-RT.id
}

resource "aws_route_table_association" "testvpc-pub-sub3-a" {
  subnet_id      = aws_subnet.testvpc-pub-sub3.id
  route_table_id = aws_route_table.testvpc-RT.id
}
