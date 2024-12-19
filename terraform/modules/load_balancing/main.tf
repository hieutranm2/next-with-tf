
module "lb_http" {
  source  = "terraform-google-modules/lb-http/google//modules/serverless_negs"
  version = "~> 12.0"

  name    = var.lb_name
  project = var.project_id
  labels  = var.labels

  ssl                             = var.ssl
  managed_ssl_certificate_domains = [var.domain]
  https_redirect                  = var.ssl

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn = var.enable_cdn

      iap_config = {
        enable = false
      }
      log_config = {
        enable = var.enable_logging
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = var.neg_name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.service_name
  }
}
