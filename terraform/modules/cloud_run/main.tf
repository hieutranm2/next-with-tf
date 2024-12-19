locals {
  image = var.service_image != "" ? var.service_image : "gcr.io/cloudrun/hello:latest"
}

resource "google_cloud_run_v2_service" "default" {
  location            = var.region
  project = var.project_id
  labels              = var.labels
  
  name                = var.service_name
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = local.image
    }
  }
}

resource "google_cloud_run_service_iam_member" "public-access" {
  location = google_cloud_run_v2_service.default.location
  project  = google_cloud_run_v2_service.default.project
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}