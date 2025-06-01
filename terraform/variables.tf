variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-south-1"
}

variable "environment" {
    description = "Deployment environment"
    type        = string
    default     = "prod"
}

# Database
variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

# Medusa Secrets
variable "medusa_secret_key" {
  description = "Medusa JWT secret key"
  type        = string
  sensitive   = true
}

variable "medusa_cookie_secret" {
  description = "Medusa session cookie secret"
  type        = string
  sensitive   = true
}

# ECS
variable "ecs_task_cpu" {
  description = "Fargate CPU units (1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "ecs_task_memory" {
  description = "Fargate memory (MB)"
  type        = number
  default     = 2048
}