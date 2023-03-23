provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    
    bucket = "state-mgmt-tuandr-sp-031623"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"


    dynamodb_table = "terraform-state-tuandr-lock"
    encrypt = true
  }
}