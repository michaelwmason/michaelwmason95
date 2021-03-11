output "ip"  {
    value = aws_instance.ci_cd_lead_node.public_ip
}

output "sg_name" {
    value = aws_security_group.ci_cd_lead_node.name
}

output "sg_id" {
    value = aws_security_group.ci_cd_lead_node.id
}