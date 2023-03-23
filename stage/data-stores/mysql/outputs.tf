output "address" {
  value = aws_db_instance.db.address
  description = "connect to the database at this endpoint"
}

output "port" {
  description = "The port the database is listening"
  value = aws_db_instance.db.port
}