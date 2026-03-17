output "ecr_repository_url" {

  description = "ECR Repository URL"

  value = aws_ecr_repository.train_ticket.repository_url
}

output "ecs_cluster_name" {

  value = aws_ecs_cluster.train_ticket_cluster.name
}

output "ecs_service_name" {

  value = aws_ecs_service.train_ticket_service.name
}

output "task_definition_arn" {

  value = aws_ecs_task_definition.train_ticket_task.arn
}
