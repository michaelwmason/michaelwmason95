output "ip" {
  value = aws_instance.ha_proxy_server.public_ip
}

output "sg_name" {
  value = aws_security_group.ha_proxy_server_sg.name
}

output "sg_id" {
  value = aws_security_group.ha_proxy_server_sg.id
}