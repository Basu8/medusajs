output "alb_dns_name" {
  description = "Medusa ALB endpoint (access the app here)"
  value       = aws_lb.medusa.dns_name
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint (for debugging)"
  value       = aws_db_instance.medusa.endpoint
  sensitive   = true
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.medusa.name
}

output "ecr_repository_url" {
  description = "ECR repository URL for Medusa Docker image"
  value       = aws_ecr_repository.medusa.repository_url
}

#######
output "alb_dns_name" {
  description = "Medusa ALB endpoint (access the app here)"
  value       = aws_lb.medusa.dns_name
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint (for debugging)"
  value       = aws_db_instance.medusa.endpoint
  sensitive   = true  # Hides value in logs
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.medusa.name
}

output "ecr_repository_url" {
  description = "ECR repository URL for Medusa Docker image"
  value       = aws_ecr_repository.medusa.repository_url
}
