variable "repository_name" {
  type        = string
  description = "The ID of the repository."
}

variable "project_id" {
  type        = string
  description = "The GCP project id"
  nullable    = true
}

variable "region" {
  type        = string
  description = "The region in which the repository will be created."
  nullable    = true
}

variable "labels" {
  type        = map(string)
  description = "A map of labels to apply to contained resources."
  default     = {}
}
