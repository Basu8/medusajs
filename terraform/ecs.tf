resource "aws_ecs_cluster" "medusa" {
  name = "medusa-cluster"
  tags = {
    Application = "medusa"
    Environment = var.environment
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "medusa-ecs-execution-role"
  description        = "Allows ECS tasks to pull images and write logs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu    # Reference variable
  memory                   = var.ecs_task_memory # Reference variable
  
  container_definitions = jsonencode([{
    name        = "medusa-container",
    image       = "${aws_ecr_repository.medusa.repository_url}:latest",
    essential   = true,
    portMappings = [{
      containerPort = 9000,
      hostPort      = 9000,  # Required for Fargate
      protocol      = "tcp"
    }],
    environment = [
      {
        name  = "NODE_ENV",
        value = var.environment
      },
      {
        name  = "DATABASE_URL",
        value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.medusa.endpoint}/medusa"
      },
      {
        name  = "MEDUSA_SECRET_KEY",
        value = var.medusa_secret_key
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options   = {
        awslogs-group         = "/ecs/medusa-${var.environment}",
        awslogs-region        = var.aws_region,
        awslogs-stream-prefix = "ecs"
      }
    }
  }])

  tags = {
    Application = "medusa"
    Environment = var.environment
  }
}