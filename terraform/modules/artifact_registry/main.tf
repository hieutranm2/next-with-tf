resource "google_artifact_registry_repository" "default" {
  location = var.region
  project  = var.project_id
  labels   = var.labels

  repository_id = var.repository_name
  format        = "DOCKER"
}
