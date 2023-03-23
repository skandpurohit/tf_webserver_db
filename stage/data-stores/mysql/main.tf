resource "aws_db_instance" "db" {
  identifier_prefix = "my-rds"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  skip_final_snapshot = true
  db_name = "myRDS_webapp"

  #Security data
  username = var.db_username
  password = var.db_password
}

