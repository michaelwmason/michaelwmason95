terraform {
  backend "s3" {
    bucket = "michaelwmason-terraform"
    key    = "sandbox"
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

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.body)
}

resource "aws_security_group" "sandbox" {
  name        = "sandbox"
  description = "sandbox"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
    self        = true
  }

  ingress {
    description = "GO CD dashboard"
    from_port   = 8153
    to_port     = 8153
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Sandbox"
  }
}


data "template_file" "init" {
  template = file("${path.cwd}/init.sh")
}

resource "aws_instance" "sandbox" {
  ami           = "ami-096fda3c22c1c990a"
  instance_type = "t2.micro"
  key_name      = "ansible_server"
  tags = {
    Name = "Sandbox"
  }

  iam_instance_profile = aws_iam_instance_profile.sandbox_instance_profile.id
  security_groups      = [aws_security_group.sandbox.name]
  user_data            = data.template_file.init.rendered
}

resource "aws_iam_role" "sandbox_role" {
  name = "sandbox_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "sandbox_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ec2:*", "cloudwatch:*"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

resource "aws_iam_instance_profile" "sandbox_instance_profile" {
  name = "sandbox_instance_profile"
  role = aws_iam_role.sandbox_role.name
}