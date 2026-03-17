resource "aws_ecr_repository" "train_ticket" {

  name = "project/train-ticket"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "train_ticket_policy" {

  repository = aws_ecr_repository.train_ticket.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"

      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }

      action = {
        type = "expire"
      }
    }]
  })
}
