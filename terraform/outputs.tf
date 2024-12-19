# We recommend that you use the following order for your output parameters:
# - Description
# - Value
# - Sensitive (optional)

output "app_url" {
  description = "The URL of the Cloud Run service."
  value       = module.cloud_run.service_uri
}