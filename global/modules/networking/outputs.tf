output "vpc-id" {
  value = aws_vpc.app-vpc.id
}

output "subnet-1" {
  value = aws_subnet.subnet-1.id
}

output "subnet-2" {
  value = aws_subnet.subnet-2.id
}

output "security-group" {
  value = aws_security_group.sg.id
}