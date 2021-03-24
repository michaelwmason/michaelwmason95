terraform {
  backend "s3" {
    bucket = "michaelwmason-terraform"
    key    = "lambda_shutdown_ec2s"
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


resource "aws_lambda_function" "shutdown_ec2s" {
  filename      = "lambda_function.zip"
  function_name = "ShutDown_Ec2s"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.8"

}