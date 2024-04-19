resource "aws_ecs_cluster" "ecs" {
  name = "app_cluster"
}

resource "aws_ecs_task_definition" "task_def" {
  execution_role_arn       = "arn:aws:iam::242451166731:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::242451166731:role/ecsTaskExecutionRole"
  family                   = "app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 2048
  memory                   = 4096
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "app",
    "image": "242451166731.dkr.ecr.us-east-1.amazonaws.com/app_repo",
    "cpu": 2048,
    "memoryReservation": 4096,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ]
  }
]
TASK_DEFINITION
}

resource "aws_ecs_service" "service" {
  name                   = "app_service"
  cluster                = aws_ecs_cluster.ecs.arn
  enable_execute_command = true
  launch_type            = "FARGATE"

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  task_definition                    = aws_ecs_task_definition.task_def.arn

  network_configuration {
    assign_public_ip = true
    subnets          = aws_subnet.subnet[*].id
    security_groups  = [aws_security_group.sg.id]
  }
}