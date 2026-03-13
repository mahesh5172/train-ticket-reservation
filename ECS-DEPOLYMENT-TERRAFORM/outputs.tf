output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}

output "task_definition" {
  value = aws_ecs_task_definition.task.family
}
