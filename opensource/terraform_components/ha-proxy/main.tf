terraform {
  backend "s3" {
    bucket = "michaelwmason-terraform"
    key    = "ha_proxy_server"
    region = "us-east-1"
  }
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

data "terraform_remote_state" "devops_server_sg" {
  backend = "s3"
  config = {
    bucket = "michaelwmason-terraform"
    key    = "devops_server"
    region = "us-east-1"
  }
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

resource "aws_security_group" "ha_proxy_server_sg" {
  name = "ha_proxy"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.devops_server_sg.outputs.sg_id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.devops_server_sg.outputs.sg_id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.devops_server_sg.outputs.sg_id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "App Server SG"
  }
}


data "template_file" "init" {
  template = file("${path.cwd}/init.sh")
}

resource "aws_instance" "ha_proxy_server" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  key_name      = "ansible_server"
  tags = {
    Name = "HaProxyServer"
  }
  security_groups = [aws_security_group.ha_proxy_server_sg.name]
  user_data       = data.template_file.init.rendered
}
