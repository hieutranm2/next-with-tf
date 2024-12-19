variable "service_name" {
  type        = string
  description = "The name of the Cloud Run service."
}

variable "service_image" {
  type        = string
  description = "The URL of the image to deploy."
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection on the Cloud Run service."
  default     = false
}

variable "region" {
  type        = string
  description = "The region in which the repository will be created."
  nullable    = true
}

variable "project_id" {
  type        = string
  description = "The GCP project id"
  nullable    = true
}

variable "labels" {
  type        = map(string)
  description = "A map of labels to apply to contained resources."
  default     = {}
}
