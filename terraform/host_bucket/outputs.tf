output "host_arn" {
  value = aws_s3_bucket.host_bucket.arn
}

output "wwwhost_arn" {
  value = aws_s3_bucket.wwwhost_bucket.arn
}