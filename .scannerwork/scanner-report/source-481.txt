output "subnet_ids" {
  description = "IDs das subnets criadas na AWS"
  value       = [aws_subnet.subnet[0].id, aws_subnet.subnet[1].id, aws_subnet.subnet[2].id]
}
