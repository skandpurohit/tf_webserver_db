provider "aws" {
    region = "us-east-1"
}


data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "state-mgmt-tuandr-sp-031623"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}


resource "aws_instance" "my_ec2" {
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.webserver_sg.name]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" >> index.html
                echo "${data.terraform_remote_state.db.outputs.address}" >> index.html
                echo "${data.terraform_remote_state.db.outputs.port}" >> index.html
                nohup busybox httpd -f -p ${var.server_port} &
    EOF


  tags = {
    "Name" = "testDBConnection"
  }
}

resource "aws_instance" "my_ec2_fancy" {
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.webserver_sg.name]

  user_data = templatefile("user-data.sh", {
    server_port = var.server_port
    db_address = data.terraform_remote_state.db.outputs.address
    db_port = data.terraform_remote_state.db.outputs.port
  })
}

resource "aws_security_group" "webserver_sg" {
  name = "webserver_sg"
  description = "Security group for webserver"
  ingress = [ {
    cidr_blocks = [ "98.38.106.144/32" ]
    description = "inbound connection to the security group"
    from_port = 8080
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 8080
  } ]
}