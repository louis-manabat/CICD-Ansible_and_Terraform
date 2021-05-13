output "endpoint" {
  description = "URL of the EC2 instance"
  value       = aws_lb.todo_app_lb.dns_name
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.todo_app_ec2[0].public_ip
}

output "docdb_endpoint" {
  description = "The DNS address for the DocDB instance"
  value       = aws_docdb_cluster.docodb.endpoint
}

output "docdb_username" {
  description = "The username for the DocDB instance"
  value       = aws_docdb_cluster.docodb.master_username
}

output "docdb_password" {
  sensitive   = true
  description = "The password for the DocDB instance"
  value       = aws_docdb_cluster.docodb.master_password
}