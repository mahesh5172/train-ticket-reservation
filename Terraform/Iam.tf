
# ECS TASK EXECUTION ROLE (Required for Fargate)

resource "aws_iam_role" "ecs_execution_role" {

  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

# Attach AWS managed policy 
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {

  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ADDITIONAL POLICY FOR ECR + LOGS

resource "aws_iam_policy" "ecs_extra_permissions" {

  name = "ecs-extra-permissions"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # ECR Permissions
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      },

      # CloudWatch Logs
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_extra_attach" {

  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_extra_permissions.arn
}


# ECS TASK ROLE (Application level permissions)

resource "aws_iam_role" "ecs_task_role" {

  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}


# EC2 ROLE (if using EC2 instances)

resource "aws_iam_role" "ec2_role" {

  name = "ec2-ecs-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

# ECS Full Access
resource "aws_iam_role_policy_attachment" "ecs_full_access" {

  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

# ECR Full Access
resource "aws_iam_role_policy_attachment" "ecr_full_access" {

  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}


# INSTANCE PROFILE (Attach to EC2)

resource "aws_iam_instance_profile" "ec2_profile" {

  name = "ec2-ecs-ecr-profile"
  role = aws_iam_role.ec2_role.name
}
