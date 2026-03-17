variable "aws_region" {
  default = "us-east-1"
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
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

variable "subnet_ids" {
  type = list(string)

  default = [
    "subnet-0c3565285007732d4",
    "subnet-0ee1b0269aa4a939c"
  ]
}

variable "security_group_ids" {
  type = list(string)

  default = [
    "sg-05add347f3ce67c0b"
  ]
}
