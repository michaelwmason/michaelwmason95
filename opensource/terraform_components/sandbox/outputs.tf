output "ip" {
  value = aws_instance.sandbox.public_ip
}

output "sg_name" {
  value = aws_security_group.sandbox.name
}

output "sg_id" {
  value = aws_security_group.sandbox.id
}