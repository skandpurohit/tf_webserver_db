variable "db_username" {
  description = "username of the myRDS Database"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "password of the myRDS Database"
  type = string
  sensitive = true
}