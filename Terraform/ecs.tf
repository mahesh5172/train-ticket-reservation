resource "aws_ecs_cluster" "train_ticket_cluster" {

  name = var.cluster_name
}

resource "aws_ecs_task_definition" "train_ticket_task" {

  family = var.task_family

  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "train-ticket"

      image = "${aws_ecr_repository.train_ticket.repository_url}:${var.image_tag}"

      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "train_ticket_service" {

  name            = var.service_name
  cluster         = aws_ecs_cluster.train_ticket_cluster.id
  task_definition = aws_ecs_task_definition.train_ticket_task.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {

    subnets = var.subnet_ids

    security_groups = var.security_group_ids

    assign_public_ip = true
  }
}
