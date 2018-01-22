variable "environment_name" {
  description = "A unique name so that other resources in the same AWS account do not conflict"
}

variable "app_image" {
  description = "Docker image to deploy"
}
