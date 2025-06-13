locals {
  module_repo_version_tag = "" # Update this tag when versioning the module
}

module "identity_provider" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-identity-provider?ref=${local.module_repo_version_tag}"

  display_name = var.display_name
  description  = var.description
  issuer       = var.issuer
  jwks_uri     = var.jwks_uri
}