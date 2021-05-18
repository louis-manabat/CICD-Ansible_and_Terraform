resource "aws_db_subnet_group" "dbs" {
  subnet_ids = [aws_subnet.data_az1.id, aws_subnet.data_az2.id, aws_subnet.data_az3.id]
}

resource "aws_docdb_cluster" "docodb" {
  cluster_identifier              = "todo-app"
  engine                          = "docdb"
  master_username                 = "mongousername"
  master_password                 = "mongopassword"
  port                            = 5432
  backup_retention_period         = 1
  skip_final_snapshot             = true
  vpc_security_group_ids          = [aws_security_group.dbsc.id]
  db_subnet_group_name            = aws_db_subnet_group.dbs.name
  db_cluster_parameter_group_name = "tls-disable"
}