output "aws_public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "aws_private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "vpc_security_group_id" {
  value = aws_security_group.app_sg.id
}

output "aws_vpc_id" {
  value = aws_vpc.app_vpc.id
}