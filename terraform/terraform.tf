terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.12.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.4"
    }
  }
  required_version = ">= 1.5"
}
