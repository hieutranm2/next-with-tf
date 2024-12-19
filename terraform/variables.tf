# (Best practices) We recommend following a consistent order for variable parameters:
# - Type
# - Description
# - Default (optional)
# - Sensitive (optional)
# - Validation blocks

variable "environment" {
  type        = string
  description = "The environment"
  default     = "development"
}

variable "app_name" {
  type        = string
  description = "The name of the application"
}

variable "project_id" {
  type        = string
  description = "The GCP project id"
}

variable "region" {
  type        = string
  description = "The GCP region"
  default     = "us-central1"
}

variable "custom_domain" {
  type        = string
  description = "The custom domain for the application"
  default     = ""
}
