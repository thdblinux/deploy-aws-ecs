output "subnet_ids" {
  description = "IDs das subnets criadas na AWS"
  value       = [aws_subnet.privsub.id, aws_subnet.pubsub.id]
}