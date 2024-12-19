module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 17.1"

  project_id                  = var.project_id
  enable_apis                 = true
  disable_services_on_destroy = false

  activate_apis = [
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
  ]
}

# Wait 30 seconds for the APIs to be enabled
resource "time_sleep" "wait_apis_enabled" {
  depends_on = [module.project_services]

  create_duration = "120s"
}

data "google_project" "project" {
  depends_on = [time_sleep.wait_apis_enabled]
}

locals {
  project_number = data.google_project.project.number
}

module "artifact_registry" {
  source = "./modules/artifact_registry"

  region     = var.region
  project_id = var.project_id
  labels = local.labels

  repository_name = "${local.name_prefix}-repo"

  depends_on = [time_sleep.wait_apis_enabled]
}

data "external" "app_image" {
  program = ["bash", "${path.module}/scripts/get_artifacts_docker_image.sh"]

  query = {
    "region"        = var.region
    "project_id"    = var.project_id
    "repo_id"       = module.artifact_registry.repo_id
    "repo_location" = module.artifact_registry.repo_location
    "image_name"    = "${local.name_prefix}-image"
  }

  depends_on = [module.artifact_registry]
}

module "cloud_run" {
  source = "./modules/cloud_run"

  region     = var.region
  project_id = var.project_id
  labels = local.labels

  service_name  = "${local.name_prefix}-service"
  service_image = data.external.app_image.result.self_link

  depends_on = [data.external.app_image]
}

module "load_balancing" {
  source = "./modules/load_balancing"

  count = var.custom_domain != "" ? 1 : 0

  region     = var.region
  project_id = var.project_id
  labels     = local.labels

  lb_name      = "${local.name_prefix}-lb"
  neg_name     = "${local.name_prefix}-neg"
  service_name = module.cloud_run.service_name

  ssl        = true
  enable_cdn = true
  domain     = var.custom_domain

  depends_on = [module.cloud_run]
}
