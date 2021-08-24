terraform {
  backend "s3" {
    bucket = "michaelwmason-terraform"
    key    = "api_gateway"
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

resource "aws_api_gateway_rest_api" "michaelwmason95" {
  name = "michaelwmason95"
}