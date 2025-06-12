locals {
  module_repo_version_tag = "v1.0.0" # Update this tag when versioning the module
}

module "cc-environment" {
  source = "/Users/shravyagennepally/Desktop/git/kafka-iac/cc-modules/cc-environment"

  environment_name           = var.environment_name
  stream_governance_package  = var.stream_governance_package
}
