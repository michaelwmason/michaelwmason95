terraform {
  backend "s3" {
    bucket = "michaelwmason-terraform"
    key    = "host_bucket"
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

resource "aws_s3_bucket" "host_bucket" {
  bucket = "michaelwmason95.com"
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::michaelwmason95.com/*"
            ]
        }
    ]
  }
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}


resource "aws_s3_bucket" "wwwhost_bucket" {
  bucket = "www.michaelwmason95.com"
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::www.michaelwmason95.com/*"
            ]
        }
    ]
  }
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}
