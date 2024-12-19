# Define local values in one of two places:
# - If you reference the local value in multiple files, define it in a file named locals.tf.
# - If the local is specific to a file, define it at the top of that file.

locals {
  env         = var.environment == "production" ? "prod" : var.environment == "staging" ? "stg" : "dev"
  name_prefix = "${local.env}-${var.app_name}"
  labels = {
    "env" = local.env
    "app" = var.app_name
  }
}
