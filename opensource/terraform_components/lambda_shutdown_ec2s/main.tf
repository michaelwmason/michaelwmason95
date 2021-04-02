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

data "archive_file" "lambda" {
  type = "zip"
  source_file = "${path.cwd}/index.py"
  output_path = "${path.cwd}/index.zip"
}


resource "aws_lambda_function" "shutdown_ec2s" {
  function_name = "ShutDown_Ec2s"
  filename      = "index.zip"
  handler       = "index.lambda_handler"
  memory_size   = 256
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.8"
  role = aws_iam_role.lambda_shutdown_ec2s_role.arn
}

resource "aws_iam_role" "lambda_shutdown_ec2s_role" {
  name = "lambda_shutdown_ec2s_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "lambda_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ec2:*"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

resource "aws_cloudwatch_event_rule" "trigger_shutdown_lambda" {
  name ="trigger_shutdown_lambda"
  is_enabled= true
  schedule_expression = "cron(0 6 ? * * *)"
}

resource "aws_cloudwatch_event_target" "shutdown_lambda" {
  arn = aws_lambda_function.shutdown_ec2s.arn
  rule  = aws_cloudwatch_event_rule.trigger_shutdown_lambda.id
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.shutdown_ec2s.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.trigger_shutdown_lambda.arn
}