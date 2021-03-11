terraform {
  backend "s3" {
    bucket = "michaelwmason-terraform"
    key    = "ci_cd_lead_node"
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

resource "aws_security_group" "ci_cd_lead_node" {
  name        = "ci_cd_lead_node"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
    self = false
  }

   ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.devops_server_sg.outputs.sg_id]
  }

   ingress {
     description = "GO CD dashboard"
    from_port   = 8153
    to_port     = 8153
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
    self = false
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOpsServer"
  }
}


data "template_file" "init" {
  template = file("${path.cwd}/init.sh")
}

resource "aws_instance" "ci_cd_lead_node" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  key_name      = "ansible_server"
  tags = {
    Name = "GoServer"
  }
  security_groups = [aws_security_group.ci_cd_lead_node.name]
  user_data       = data.template_file.init.rendered
}
