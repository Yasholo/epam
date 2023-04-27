output "vm1_sg_id" {
  value = aws_security_group.vm1-sg.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}