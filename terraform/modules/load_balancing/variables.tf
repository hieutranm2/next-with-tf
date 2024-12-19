variable "lb_name" {
  type        = string
  description = "The name of the load balancer."
}

variable "neg_name" {
  type        = string
  description = "The name of the network endpoint group."
}

variable "service_name" {
  type        = string
  description = "The name of the Cloud Run service."
}

variable "ssl" {
  type        = bool
  description = "Whether to use SSL on the load balancer."
  default     = true
}

variable "domain" {
  type        = string
  description = "The custom domain to use for the SSL certificate."
}

variable "enable_cdn" {
  type        = bool
  description = "Whether to enable the CDN on the load balancer."
  default     = false
}

variable "enable_iap" {
  type        = bool
  description = "Whether to enable the IAP on the load balancer."
  default     = false
}

variable "enable_logging" {
  type        = bool
  description = "Whether to enable logging on the load balancer."
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
