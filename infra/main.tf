provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "dbsc" {
  description = "Allow document DB traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "documentdb from vpc"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-docdb-traffic"
  }
}

resource "aws_security_group" "allow_http_ssh" {
  description = "Allowing HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}

# loadbal sec group http for 80 ["0.0.0.0/0"]
# instance sec group 22 and 5000 [aws_vpc.vpc.cidr_block]

resource "" "name" {
  ingress {
    description = "SSH from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}