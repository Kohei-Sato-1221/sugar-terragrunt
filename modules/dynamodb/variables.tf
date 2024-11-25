variable "variables" {}
variable "s3_bucket_name" {
  default = "not_set"
}

locals {
  variables = yamldecode(var.variables)

  app_name    = local.variables.app_name
  environment = local.variables.environment
}