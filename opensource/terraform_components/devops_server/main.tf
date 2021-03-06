terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.body)
}

resource "aws_security_group" "deny_all" {
  name        = "deny_all"
  description = "Deny All"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Deny All"
  }
}


data "template_file" "init" {
  template = file("${path.cwd}/init.sh")
}

resource "aws_instance" "devops_server" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  key_name      = "ansible_server"
  tags = {
    Name = "DevOpsServer"
  }
  security_groups = [aws_security_group.deny_all.name]
  user_data       = data.template_file.init.rendered
}

