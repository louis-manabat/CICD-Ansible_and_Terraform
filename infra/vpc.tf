resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "s3719633-a2-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "s3719633-a2-igw"
  }
}

resource "aws_default_route_table" "drt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "s3719633-a2-drt"
  }
}

resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-public-az1"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.4.0/22"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-public-az2"
  }
}

resource "aws_subnet" "public_az3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.8.0/22"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-public-az3"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.16.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-private-az1"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.20.0/22"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-private-az2"
  }
}

resource "aws_subnet" "private_az3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.24.0/22"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-private-az3"
  }
}

resource "aws_subnet" "data_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.32.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-data-az1"
  }
}

resource "aws_subnet" "data_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.36.0/22"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-data-az2"
  }
}

resource "aws_subnet" "data_az3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.40.0/22"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "a2-data-az3"
  }
}

resource "aws_lb" "todo_app_lb" {
  name               = "todo-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_ssh.id]
  subnets            = [aws_subnet.public_az1.id, aws_subnet.public_az2.id, aws_subnet.public_az3.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "todo_app_lb_tg" {
  name     = "todo-app-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}