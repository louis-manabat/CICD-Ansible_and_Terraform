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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-docdb-traffic"
  }
}

resource "aws_db_subnet_group" "dbsg" {
  subnet_ids = [aws_subnet.data_az1.id, aws_subnet.data_az2.id, aws_subnet.data_az3.id]
}

resource "aws_docdb_cluster" "docodb" {
  cluster_identifier              = "todo-app"
  engine                          = "docdb"
  master_username                 = "mongousername"
  master_password                 = "mongopassword"
  port                            = 27017
  backup_retention_period         = 1
  skip_final_snapshot             = true
  vpc_security_group_ids          = [aws_security_group.dbsc.id]
  db_subnet_group_name            = aws_db_subnet_group.dbsg.name
  db_cluster_parameter_group_name = "tls-disable"
}