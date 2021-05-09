provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "dbsc" {
  description = "Allow document DB traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "documentdb from vpc"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-docdb-traffic"
  }
}