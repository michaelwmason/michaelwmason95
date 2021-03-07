output "ip"  {
    value = aws_instance.devops_server.public_ip
}

output "sg_name" {
    value = aws_security_group.deny_all.name
}

output "sg_id" {
    value = aws_security_group.deny_all.id
}