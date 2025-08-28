output "vpc_id" {
    value = aws_vpc.main.id
    description = "VPC ID"
  
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
    description = "List of private subnet IDs"
  
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
    description = "List of public subnet IDs"
  
}