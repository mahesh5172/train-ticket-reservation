variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "train-cluster"
}

variable "service_name" {
  default = "train-service"
}

variable "task_family" {
  default = "train-task"
}

variable "container_name" {
  default = "train-container"
}

variable "container_port" {
  default = 8080
}

variable "image_url" {
  description = "ECR Image URL"
  default     = "367398820534.dkr.ecr.us-east-1.amazonaws.com/project/train-ticket:1773398197"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}
